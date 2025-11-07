import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sizer/sizer.dart';

import 'package:file_picker/file_picker.dart';
import 'package:ssinfra/view/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sizer',
          theme: ThemeData.light(),
          home: SplashScreen(),
          // home: DynamicFormScreen() ,
          // home: FormScreen() ,
        );
      },
    );
  }
}

class DynamicFormController extends GetxController {
  RxList<QuestionModel> questions = <QuestionModel>[].obs;
  RxList<AnswerModel> answers = <AnswerModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadQuestions();
  }

  void loadQuestions() {
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
                "unit": 1,
                "rules": [],
              },
              {
                "id": 11,
                "type": "number",
                "is_required": true,
                "label": "During the winter season",
                "unit": 1,
                "rules": [],
              },
              {
                "id": 12,
                "type": "number",
                "is_required": true,
                "label": "During the summer season",
                "unit": 1,
                "rules": [],
              },
            ],
          },
        ],
      },
    };

    final data = response["data"] as Map<String, dynamic>?;
    final fields = data?["fields"] as List<dynamic>? ?? [];
    questions.value = fields.map((e) => QuestionModel.fromJson(e)).toList();

    // generate flattened answers (including children)
    answers.value = _generateAnswers(questions);
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
      ans.answer = value;
      answers.refresh();
    }
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

  void submit() {
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
}

// ========================== VIEW ==========================

class DynamicFormScreen extends StatelessWidget {
  final DynamicFormController c = Get.put(DynamicFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dynamic Form (API Response)")),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: c.questions.map((q) => _buildQuestion(q)).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: c.submit,
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget _buildQuestion(QuestionModel q) {
    final visible = c.shouldShowQuestion(q);

    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (q.type != "label")
              Text(
                "${q.id}. ${q.label}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (q.type != "label") const SizedBox(height: 8),
            _buildField(q),
            if (q.childrens.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Column(
                  children: q.childrens.map((e) => _buildQuestion(e)).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(QuestionModel q) {
    final ans =
        c.answers.firstWhereOrNull((a) => a.id == q.id) ??
        AnswerModel(id: q.id, answer: null);

    switch (q.type) {
      case "radio":
        return Column(
          children: q.options
              .map(
                (opt) => RadioListTile<int>(
                  title: Text(opt.label),
                  value: opt.id,
                  groupValue: ans.answer,
                  onChanged: (v) => c.updateAnswer(q.id, v),
                ),
              )
              .toList(),
        );

      case "checkbox":
        List<int> selected = (ans.answer ?? []).cast<int>();
        final maxSelect = q.maxSelect ?? q.options.length;

        return Column(
          children: q.options.map((opt) {
            final isChecked = selected.contains(opt.id);
            return CheckboxListTile(
              title: Text(opt.label),
              value: isChecked,
              onChanged: (v) {
                if (v == true) {
                  if (selected.length >= maxSelect) {
                    Get.snackbar(
                      "Limit reached",
                      "Maximum $maxSelect choices allowed.",
                      backgroundColor: Colors.orangeAccent,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  selected.add(opt.id);
                } else {
                  selected.remove(opt.id);
                }
                c.updateAnswer(q.id, List.from(selected));
              },
            );
          }).toList(),
        );

      case "select":
        return DropdownButtonFormField<int>(
          decoration: const InputDecoration(border: OutlineInputBorder()),
          value: ans.answer,
          items: q.options
              .map(
                (opt) =>
                    DropdownMenuItem(value: opt.id, child: Text(opt.label)),
              )
              .toList(),
          onChanged: (v) => c.updateAnswer(q.id, v),
        );

      case "input":
        return TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "Enter ${q.label}",
          ),
          onChanged: (v) => c.updateAnswer(q.id, v),
        );

      case "number":
        return TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "Enter ${q.label}",
          ),
          keyboardType: TextInputType.number,
          onChanged: (v) => c.updateAnswer(q.id, v),
        );

      case "file":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  c.updateAnswer(q.id, result.files.single.name);
                }
              },
              icon: const Icon(Icons.upload_file),
              label: const Text("Upload File"),
            ),
            if (ans.answer != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("Selected file: ${ans.answer}"),
              ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }
}

// ========================== MODELS ==========================

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
    );
  }
}

class OptionModel {
  final int id;
  final String label;

  OptionModel({required this.id, required this.label});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(id: json["id"], label: json["label"] ?? "");
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

class AnswerModel {
  final int id;
  dynamic answer;
  AnswerModel({required this.id, required this.answer});
}
