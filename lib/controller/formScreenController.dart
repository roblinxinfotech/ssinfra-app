import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';

import 'package:ssinfra/services/apiEndPoint.dart';
import 'package:ssinfra/services/apiServices.dart';

class DynamicFormController extends GetxController {
  RxList<QuestionModel> questions = <QuestionModel>[].obs;
  RxList<AnswerModel> answers = <AnswerModel>[].obs;
  final ScrollController scrollController = ScrollController();
  RxDouble progress = 0.0.obs;
  RxBool showLoader = true.obs;
  RxBool error = false.obs;
  RxInt id = 0.obs;
  RxString code = "".obs;
  RxString title = "".obs;

  @override
  void onInit() {
    super.onInit();

    loadQuestions();
    updateProgress();
  }

  void loadQuestions() async {
    try {
      var res = await ApiServices().getData(
        url: "${ApiEndPoint.vFormField}1${ApiEndPoint.language}en",
      );
      await Future.delayed(Duration(seconds: 3), () {});
      var datas = jsonDecode(res);
      print(datas);
      // use live API response
      const response = {
        "status": 200,
        "message": "Form fields fetched successfully.",
        "data": {
          "id": 1,
          "code": "01",
          "title": "Ground water plan",
          "fields": [
            {
              "id": 1,
              "type": "radio",
              "is_required": true,
              "label": "What industry are you in?",
              "options": [
                {"id": 1, "code": 1, "label": "Accounting"},
                {"id": 2, "code": 2, "label": "Engineering"},
              ],
              "rules": [],
            },
            {
              "id": 2,
              "type": "checkbox",
              "is_required": true,
              "label": "How did you find out about our product?",
              "min_select": 1,
              "max_select": 1,
              "options": [
                {"id": 3, "code": 1, "label": "A friend recommended it to me!"},
                {"id": 4, "code": 2, "label": "Instagram"},
                {"id": 5, "code": 3, "label": "Facebook"},
                {"id": 6, "code": 4, "label": "Youtube"},
                {"id": 7, "code": 5, "label": "Google Ads"},
                {"id": 8, "code": 6, "label": "Other"},
              ],
              "rules": [
                {
                  "action": "hide",
                  "condition_type": "not_equals",
                  "depends_on": 1,
                  "depends_value": "1",
                },
                {
                  "action": "show",
                  "condition_type": "equals",
                  "depends_on": 6,
                  "depends_value": "9",
                },
              ],
            },
            {
              "id": 5,
              "type": "input",
              "is_required": true,
              "label": "Scheme name",
              "text_min_limit": 10,
              "text_max_limit": 50,
              "rules": [],
            },
            {
              "id": 6,
              "type": "select",
              "is_required": true,
              "label":
                  "Which flies a green, white, and orange (in that order) tricolor flag?",
              "options": [
                {"id": 9, "code": 1, "label": "Ireland"},
                {"id": 10, "code": 2, "label": "Ivory Coast"},
                {"id": 11, "code": 3, "label": "Italy"},
              ],
              "rules": [],
            },
            {
              "id": 7,
              "type": "file",
              "is_required": true,
              "label": "Please upload village map",
              "rules": [],
            },
            {
              "id": 8,
              "type": "number",
              "is_required": true,
              "label": "Village area",
              "unit": 1,
              "rules": [],
            },
            {
              "id": 9,
              "type": "label",
              "is_required": false,
              "label": "Days of pump usage",
              "rules": [],
              "childrens": [
                {
                  "id": 10,
                  "type": "number",
                  "is_required": true,
                  "label": "During the monsoon season",
                  "unit": {"symbol": "ha", "name": "Hectare"},
                  "rules": [],
                },
                {
                  "id": 11,
                  "type": "number",
                  "is_required": true,
                  "label": "During the winter season",
                  "unit": {"symbol": "ha", "name": "Hectare"},
                  "rules": [],
                },
                {
                  "id": 12,
                  "type": "number",
                  "is_required": true,
                  "label": "During the summer season",
                  "unit": {"symbol": "ha", "name": "Hectare"},
                  "rules": [],
                },
              ],
            },
          ],
        },
      };

      final data = datas["data"] as Map<String, dynamic>?;
      id.value = data?["id"];
      code.value = data?["code"];
      title.value = data?["title"];
      final fields = data?["fields"] as List<dynamic>? ?? [];
      questions.value = fields.map((e) => QuestionModel.fromJson(e)).toList();
      showLoader.value = false;
      error.value = false;
    } catch (e) {
      showLoader.value = false;
      error.value = true;
    }
    showLoader.value = false;

    // generate flattened answers (including children)
    answers.value = _generateAnswers(questions);

    // 🔄 Calculate initial autofill values
    _calculateInitialAutofills();
  }

  List<AnswerModel> _generateAnswers(List<QuestionModel> qs) {
    final result = <AnswerModel>[];
    for (final q in qs) {
      result.add(AnswerModel(id: q.id, answer: null));
      if (q.childrens.isNotEmpty) {
        result.addAll(_generateAnswers(q.childrens));
      }
    }
    return result;
  }

  /// update an answer and refresh observables
  void updateAnswer(int id, dynamic value) {
    final ans = answers.firstWhereOrNull((a) => a.id == id);
    if (ans != null) {
      // 🧠 Handle checkbox special case — if no selections left, treat as null
      if (value is List && value.isEmpty) {
        ans.answer = null;
      } else if (value == null || (value is String && value.trim().isEmpty)) {
        ans.answer = null;
      } else {
        ans.answer = value;
      }

      answers.refresh();
      updateProgress(); // 🔁 Recalculate progress every time

      // 🔄 Trigger autofill recalculation for fields that depend on this field
      _recalculateAutofillFields(id);
    }
  }

  /// Helper to flatten only visible questions
  List<QuestionModel> _getVisibleQuestions(List<QuestionModel> qs) {
    final result = <QuestionModel>[];
    for (final q in qs) {
      if (shouldShowQuestion(q)) {
        result.add(q);
        if (q.childrens.isNotEmpty) {
          result.addAll(_getVisibleQuestions(q.childrens));
        }
      }
    }
    return result;
  }

  Widget gradientProgressBar(double progress) {
    // Clamp progress between 0 and 1
    progress = progress.clamp(0.0, 1.0);

    return Container(
      height: 28, // same height as shown in image
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // Gradient progress
          LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: constraints.maxWidth * progress,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple,
                      Colors.red,
                      Colors.orange,
                      Colors.yellow,
                      Colors.green,
                      Colors.blue,
                    ],
                  ),
                ),
              );
            },
          ),

          // Percentage text (centered)
          Center(
            child: Text(
              "${(progress * 100).toStringAsFixed(0)}%",
              style: TextStyle(
                color: Colors.black87,
                fontFamily: "PlusJakartaSansMedium",
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateProgress() {
    final visibleQs = _getVisibleQuestions(questions);
    final requiredQs = visibleQs.where((q) => q.isRequired).toList();

    if (requiredQs.isEmpty) {
      progress.value = 0.0;
      return;
    }

    int answered = 0;
    for (final q in requiredQs) {
      final ans = answers.firstWhereOrNull((a) => a.id == q.id);
      if (ans != null &&
          ans.answer != null &&
          ans.answer.toString().isNotEmpty) {
        answered++;
      }
    }

    progress.value = (answered / requiredQs.length).clamp(0.0, 1.0);
  }

  /// Evaluate a single rule: returns true when the rule condition is satisfied
  bool _evaluateRule(RuleModel rule) {
    if (rule.dependsOn == null) return false;
    final depAns = answers.firstWhereOrNull((a) => a.id == rule.dependsOn);
    final depVal = depAns?.answer;

    final String depStr = depVal?.toString() ?? "";
    final String ruleVal = rule.dependsValue?.toString() ?? "";

    switch (rule.conditionType) {
      case 'equals':
        return depStr.isNotEmpty && depStr == ruleVal;
      case 'not_equals':
        // If depVal is null treat as not equal (so not_equals evaluates true)
        if (depAns == null || depVal == null) return true;
        return depStr != ruleVal;
      default:
        return false;
    }
  }

  /// Returns true when the question should be visible.
  /// Logic:
  ///  - If any hide rule evaluates true -> hidden (return false)
  ///  - If there are show rules: visible only if at least one show rule evaluates true
  ///  - If no rules -> visible
  bool shouldShowQuestion(QuestionModel q) {
    // ✅ Show all by default until a dependent answer is filled
    bool hasAnswerDependency = q.rules.any((r) => r.dependsOn != null);
    bool anyDependencyAnswered = q.rules.any((r) {
      final depAns = answers.firstWhereOrNull((a) => a.id == r.dependsOn);
      return depAns?.answer != null && depAns!.answer.toString().isNotEmpty;
    });

    // if rule exists but dependency not answered yet → show by default
    if (hasAnswerDependency && !anyDependencyAnswered) {
      return true;
    }

    // ====== Then evaluate actual rule logic ======

    if (q.rules.isEmpty) return true;

    // 1) if any hide rule is matched -> hide
    for (final r in q.rules.where((r) => r.action == 'hide')) {
      if (_evaluateRule(r)) {
        return false;
      }
    }

    // 2) if show rules exist -> show only if any matches
    final showRules = q.rules.where((r) => r.action == 'show').toList();
    if (showRules.isNotEmpty) {
      final anyShowMatch = showRules.any(_evaluateRule);
      return anyShowMatch;
    }

    return true;
  }

  bool validateForm() {
    for (final q in questions) {
      if (!_validateQuestion(q)) return false;
    }
    return true;
  }

  bool _validateQuestion(QuestionModel q) {
    if (!shouldShowQuestion(q)) return true; // hidden -> treat as valid

    final ans = answers.firstWhereOrNull((a) => a.id == q.id);
    if (q.isRequired) {
      if (q.type == 'checkbox') {
        final List sel = (ans?.answer ?? []).cast<dynamic>();
        final min = q.minSelect ?? 0;
        final max = q.maxSelect ?? q.options.length;
        if (sel.length < min) {
          Get.snackbar(
            "Missing",
            "Please select at least $min options for '${q.label}'.",
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
          return false;
        }
        if (sel.length > max) {
          Get.snackbar(
            "Missing",
            "Please select at most $max options for '${q.label}'.",
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
          return false;
        }
      } else {
        final value = ans?.answer?.toString().trim() ?? "";
        if (value.isEmpty) {
          Get.snackbar(
            "Missing",
            "Please provide answer for '${q.label}'.",
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
          return false;
        }

        // ✅ Text limit validation
        if (q.type == "input") {
          final min = q.textMinLimit ?? 0;
          final max = q.textMaxLimit ?? 10000;
          if (value.length < min) {
            Get.snackbar(
              "Too short",
              "Answer for '${q.label}' must be at least $min characters.",
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
            );
            return false;
          }
          if (value.length > max) {
            Get.snackbar(
              "Too long",
              "Answer for '${q.label}' must be no more than $max characters.",
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
            );
            return false;
          }
        }
      }
    }

    for (final ch in q.childrens) {
      if (!_validateQuestion(ch)) return false;
    }
    return true;
  }

  submit() {
    if (!validateForm()) return;

    final result = <Map<String, dynamic>>[];
    for (final q in questions) {
      _collectAnswers(q, result);
    }

    debugPrint("✅ Submitted Answers => $result");
    Get.snackbar(
      "Success",
      "Form submitted successfully!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void _collectAnswers(QuestionModel q, List<Map<String, dynamic>> list) {
    if (!shouldShowQuestion(q)) return;
    final ans = answers.firstWhereOrNull((a) => a.id == q.id);
    if (ans != null && ans.answer != null && ans.answer.toString().isNotEmpty) {
      list.add({"id": q.id, "answer": ans.answer});
    }
    for (final ch in q.childrens) {
      _collectAnswers(ch, list);
    }
  }

  /// Recalculate autofill fields that depend on the updated field
  void _recalculateAutofillFields(int updatedFieldId) {
    // Find all questions (including children) that have autofill
    final allQuestions = _getAllQuestions(questions);

    for (final q in allQuestions) {
      if (q.autofill != null && q.autofill!.plainFormula != null) {
        // Check if this autofill formula references the updated field
        final formula = q.autofill!.plainFormula!;
        final fieldIdPattern = RegExp(r'\{(\d+)\}');
        final matches = fieldIdPattern.allMatches(formula);

        bool dependsOnUpdatedField = false;
        for (final match in matches) {
          final fieldId = int.tryParse(match.group(1) ?? '');
          if (fieldId == updatedFieldId) {
            dependsOnUpdatedField = true;
            break;
          }
        }

        if (dependsOnUpdatedField) {
          _evaluateAutofill(q);
        }
      }
    }
  }

  /// Get all questions including children in a flat list
  List<QuestionModel> _getAllQuestions(List<QuestionModel> qs) {
    final result = <QuestionModel>[];
    for (final q in qs) {
      result.add(q);
      if (q.childrens.isNotEmpty) {
        result.addAll(_getAllQuestions(q.childrens));
      }
    }
    return result;
  }

  /// Evaluate autofill formula for a question
  void _evaluateAutofill(QuestionModel q) {
    if (q.autofill == null || q.autofill!.plainFormula == null) return;

    final formula = q.autofill!.plainFormula!;
    final fieldIdPattern = RegExp(r'\{(\d+)\}');

    // Replace field IDs with their actual values
    String evaluatedFormula = formula;
    final matches = fieldIdPattern.allMatches(formula);

    for (final match in matches) {
      final fieldId = int.tryParse(match.group(1) ?? '');
      if (fieldId != null) {
        final depAns = answers.firstWhereOrNull((a) => a.id == fieldId);
        final depValue = depAns?.answer;

        if (depValue == null) {
          // If any dependency is null, set autofill field to null
          final ans = answers.firstWhereOrNull((a) => a.id == q.id);
          if (ans != null) {
            ans.answer = null;
          }
          answers.refresh();
          updateProgress();
          return;
        }

        // Convert to number for calculation
        final numValue = _parseToNumber(depValue);
        if (numValue == null) {
          // If value cannot be parsed, set autofill field to null
          final ans = answers.firstWhereOrNull((a) => a.id == q.id);
          if (ans != null) {
            ans.answer = null;
          }
          answers.refresh();
          updateProgress();
          return;
        }

        evaluatedFormula = evaluatedFormula.replaceAll(
          '{$fieldId}',
          numValue.toString(),
        );
      }
    }

    // Evaluate the formula
    try {
      final result = _evaluateExpression(evaluatedFormula);
      if (result != null) {
        final ans = answers.firstWhereOrNull((a) => a.id == q.id);
        if (ans != null) {
          // Format result appropriately (remove unnecessary decimals)
          if (result % 1 == 0) {
            ans.answer = result.toInt().toString();
          } else {
            ans.answer = result
                .toStringAsFixed(2)
                .replaceAll(RegExp(r'\.?0+$'), '');
          }
          answers.refresh();
          updateProgress();
        }
      }
    } catch (e) {
      debugPrint('Error evaluating autofill formula: $e');
    }
  }

  /// Parse a value to a number
  num? _parseToNumber(dynamic value) {
    if (value is num) return value;
    if (value is String) {
      final cleaned = value.trim().replaceAll(RegExp(r'[^\d.-]'), '');
      return num.tryParse(cleaned);
    }
    return null;
  }

  /// Evaluate a mathematical expression safely - fully dynamic evaluator
  num? _evaluateExpression(String expression) {
    try {
      // Remove any whitespace
      expression = expression.trim().replaceAll(' ', '');

      // Use dynamic expression evaluator that handles any mathematical operations
      return _evaluateDynamic(expression);
    } catch (e) {
      debugPrint('Error evaluating expression: $expression - $e');
      return null;
    }
  }

  /// Fully dynamic expression evaluator supporting +, -, *, /, %, and parentheses
  /// Follows operator precedence: parentheses > *, /, % > +, -
  num _evaluateDynamic(String expression) {
    expression = expression.trim();

    // Handle parentheses first (highest precedence)
    int parenStart = expression.lastIndexOf('(');
    if (parenStart >= 0) {
      int parenEnd = expression.indexOf(')', parenStart);
      if (parenEnd < 0) throw FormatException('Unmatched parenthesis');

      String before = expression.substring(0, parenStart);
      String inside = expression.substring(parenStart + 1, parenEnd);
      String after = expression.substring(parenEnd + 1);

      num insideValue = _evaluateDynamic(inside);
      return _evaluateDynamic(before + insideValue.toString() + after);
    }

    // Handle multiplication, division, and modulo (same precedence, left to right)
    int multIndex = _findOperatorIndex(expression, '*');
    int divIndex = _findOperatorIndex(expression, '/');
    int modIndex = _findOperatorIndex(expression, '%');

    // Find the leftmost operator among *, /, %
    int? mdIndex;
    String? mdOp;

    // Check multiplication
    if (multIndex >= 0 && (mdIndex == null || multIndex < mdIndex)) {
      mdIndex = multIndex;
      mdOp = '*';
    }
    // Check division
    if (divIndex >= 0 && (mdIndex == null || divIndex < mdIndex)) {
      mdIndex = divIndex;
      mdOp = '/';
    }
    // Check modulo
    if (modIndex >= 0 && (mdIndex == null || modIndex < mdIndex)) {
      mdIndex = modIndex;
      mdOp = '%';
    }

    if (mdIndex != null && mdOp != null) {
      num left = _evaluateDynamic(expression.substring(0, mdIndex));
      num right = _evaluateDynamic(expression.substring(mdIndex + 1));

      switch (mdOp) {
        case '*':
          return left * right;
        case '/':
          if (right == 0) throw FormatException('Division by zero');
          return left / right;
        case '%':
          if (right == 0) throw FormatException('Modulo by zero');
          return left % right;
        default:
          throw FormatException('Unknown operator: $mdOp');
      }
    }

    // Handle addition and subtraction (lowest precedence, left to right)
    int plusIndex = _findOperatorIndex(expression, '+');
    int minusIndex = _findOperatorIndex(expression, '-');

    // Find the leftmost operator among +, -
    int? asIndex;
    String? asOp;

    // Check addition
    if (plusIndex >= 0 && (asIndex == null || plusIndex < asIndex)) {
      asIndex = plusIndex;
      asOp = '+';
    }
    // Check subtraction
    if (minusIndex >= 0 && (asIndex == null || minusIndex < asIndex)) {
      asIndex = minusIndex;
      asOp = '-';
    }

    if (asIndex != null && asOp != null) {
      num left = _evaluateDynamic(expression.substring(0, asIndex));
      num right = _evaluateDynamic(expression.substring(asIndex + 1));

      switch (asOp) {
        case '+':
          return left + right;
        case '-':
          return left - right;
        default:
          throw FormatException('Unknown operator: $asOp');
      }
    }

    // Base case: parse number (handles negative numbers)
    return num.parse(expression);
  }

  /// Find the index of an operator, avoiding negative number signs
  /// Returns -1 if not found
  int _findOperatorIndex(String expression, String operator) {
    int index = 0;
    while (true) {
      index = expression.indexOf(operator, index);
      if (index < 0) return -1;

      // Check if this is a negative sign (not an operator)
      // It's a negative sign if:
      // 1. It's at the start of expression
      // 2. It's preceded by an operator (+, -, *, /, %, ())
      if (index == 0) {
        // At start, could be negative number
        if (operator == '-') {
          index++;
          continue;
        }
        return index;
      }

      // Check previous character
      String prevChar = expression[index - 1];
      if (operator == '-' &&
          (prevChar == '+' ||
              prevChar == '-' ||
              prevChar == '*' ||
              prevChar == '/' ||
              prevChar == '%' ||
              prevChar == '(')) {
        // This is a negative sign, not subtraction
        index++;
        continue;
      }

      return index;
    }
  }

  /// Calculate initial autofill values when questions are loaded
  void _calculateInitialAutofills() {
    final allQuestions = _getAllQuestions(questions);
    for (final q in allQuestions) {
      if (q.autofill != null && q.autofill!.plainFormula != null) {
        _evaluateAutofill(q);
      }
    }
  }
}

class QuestionModel {
  final int id;
  final String label;
  final String type;
  final bool isRequired;
  final List<OptionModel> options;
  final List<RuleModel> rules;
  final List<QuestionModel> childrens;
  final int? minSelect;
  final int? maxSelect;
  final int? textMinLimit;
  final int? textMaxLimit;
  final UnitModel? unit;
  final AutofillModel? autofill;

  QuestionModel({
    required this.id,
    required this.label,
    required this.type,
    required this.isRequired,
    required this.options,
    required this.rules,
    required this.childrens,
    this.minSelect,
    this.maxSelect,
    this.textMaxLimit,
    this.textMinLimit,
    this.unit,
    this.autofill,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json["id"],
      label: json["label"] ?? "",
      type: json["type"] ?? "input",
      isRequired: json["is_required"] ?? false,
      options:
          (json["options"] as List?)
              ?.map((e) => OptionModel.fromJson(e))
              .toList() ??
          [],
      rules:
          (json["rules"] as List?)
              ?.map((e) => RuleModel.fromJson(e))
              .toList() ??
          [],
      childrens:
          (json["childrens"] as List?)
              ?.map((e) => QuestionModel.fromJson(e))
              .toList() ??
          [],
      minSelect: json["min_select"],
      maxSelect: json["max_select"],
      textMinLimit: json["text_min_limit"],
      textMaxLimit: json["text_max_limit"],
      unit: json["unit"] is Map<String, dynamic>
          ? UnitModel.fromJson(json["unit"])
          : null,
      autofill:
          json["autofill"] != null && json["autofill"] is Map<String, dynamic>
          ? AutofillModel.fromJson(json["autofill"])
          : null,
    );
  }
}

class OptionModel {
  final int id;
  final int? code;
  final String label;

  OptionModel({required this.id, required this.label, this.code});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json["id"],
      label: json["label"] ?? "",
      code: json["code"],
    );
  }
}

class RuleModel {
  final String action;
  final String? conditionType;
  final int? dependsOn;
  final dynamic dependsValue;

  RuleModel({
    required this.action,
    this.conditionType,
    this.dependsOn,
    this.dependsValue,
  });

  factory RuleModel.fromJson(Map<String, dynamic> json) {
    return RuleModel(
      action: json["action"],
      conditionType: json["condition_type"],
      dependsOn: json["depends_on"],
      dependsValue: json["depends_value"],
    );
  }
}

class UnitModel {
  final String? symbol;
  final String? name;

  UnitModel({this.symbol, this.name});

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(symbol: json["symbol"], name: json["name"]);
  }
}

class AnswerModel {
  final int id;
  dynamic answer;

  AnswerModel({required this.id, required this.answer});
}

class AutofillModel {
  final String? sourceFormId;
  final String? plainFormula;

  AutofillModel({this.sourceFormId, this.plainFormula});

  factory AutofillModel.fromJson(Map<String, dynamic> json) {
    return AutofillModel(
      sourceFormId: json["source_form_id"]?.toString(),
      plainFormula: json["plain_formula"]?.toString(),
    );
  }
}
