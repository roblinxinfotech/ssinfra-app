import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/model/assignedVillageWardModel.dart';

import 'package:ssinfra/services/apiEndPoint.dart';
import 'package:ssinfra/services/apiServices.dart';

import '../model/categoryModel.dart';
import '../model/wardListDataModel.dart';
import '../utils/commonWidgets.dart';
import '../utils/formula_evaluator.dart';

class DynamicFormController extends GetxController {
  RxList<QuestionModel> questions = <QuestionModel>[].obs;
  Rx<AssignedVillageWardModel> assignedVillageWardModel =
      AssignedVillageWardModel().obs;
  Rx<WardListDataModel> wardListDataModel = WardListDataModel().obs;
  RxList<AnswerModel> answers = <AnswerModel>[].obs;
  final ScrollController scrollController = ScrollController();
  RxDouble progress = 0.0.obs;
  RxBool showLoader = true.obs;
  RxBool error = false.obs;
  RxInt id = 0.obs;
  RxString code = "".obs;
  RxString title = "".obs;
  String formId = "";
  var arguments;

  final ImagePicker picker = ImagePicker();
  Rx<CategoryModel> categoryModel = CategoryModel().obs;
  RxList<CategoryList> categoryList = <CategoryList>[].obs;
  RxnInt storedCategory = RxnInt();
  RxnInt wardStored = RxnInt();
  RxnInt villageStored = RxnInt();
  RxList<FilledFormModel> allForms = <FilledFormModel>[].obs;
  RxList<FilledFormModel> filledForm = <FilledFormModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    loadQuestions();
    updateProgress();
  }

  void loadQuestions() async {
    arguments = Get.arguments;
    formId = arguments["formId"];
    print(formId);
    try {
      var categoryResponse = await ApiServices().getData(
        url: ApiEndPoint.category,
      );

      categoryModel.value = CategoryModel.fromJson(
        json.decode(categoryResponse),
      );
      categoryList.clear();
      categoryModel.value.data?.forEach((action) {
        categoryList.add(action);
      });

      if (categoryList.length != 0) {
        storedCategory.value = categoryList[0].id;
        // if(categoryList[0].name=="rural")
        //   {
        //
        //   }else if(categoryList[0].name=="urban")
        //     {
        //
        //     }
        // // await getUrbanData(storedCategory.value);
      }

      await getAssignedWard();
      await getAssignedVillage();
      final prefs = await SharedPreferences.getInstance();
      final langCode = prefs.getString('languageCode');
      var res = await ApiServices().getData(
        url:
            "${ApiEndPoint.vFormField}${formId}${ApiEndPoint.language}${langCode}",
      );

      // await Future.delayed(Duration(seconds: 3), () {});
      var datas = jsonDecode(res);
      print(datas);
      // use live API response (fallback to static data if needed)
      const Map<String, dynamic> fallbackResponse = {
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
            // {
            //   "id": 7,
            //   "type": "file",
            //   "is_required": true,
            //   "label": "Please upload village map",
            //   "rules": [],
            // },
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

      late final Map<String, dynamic> response;
      if (datas is Map<String, dynamic> && datas["data"] != null) {
        response = Map<String, dynamic>.from(datas);
      } else {
        response = fallbackResponse;
      }

      final data = response["data"] as Map<String, dynamic>?;
      id.value = data?["id"];
      code.value = data?["code"];
      title.value = data?["title"];
      final fields = data?["fields"] as List<dynamic>? ?? [];
      final surveyIds = data?["survey_ids"] as List<dynamic>? ?? [];
      questions.value = fields.map((e) => QuestionModel.fromJson(e)).toList();
      allForms.value = surveyIds
          .map((e) => FilledFormModel.fromJson(e))
          .toList();
      allForms.forEach((action) {
        filledForm.addIf(action.surveyId == wardStored.value, action);
      });
      print(filledForm.length);
      print("filledForm.length");
      showLoader.value = false;
      error.value = false;
    } catch (e) {
      showLoader.value = false;
      error.value = true;
      print(e);
    }
    showLoader.value = false;

    // generate flattened answers (including children)
    answers.value = _generateAnswers(questions);

    // 🧾 Prefill existing answers coming from API (if any)
    _applyPrefilledAnswers(questions);

    // 🔄 Set default values for options with is_default: 1
    _setDefaultValues();

    // 🔄 Calculate initial autofill values (after defaults are set)
    _calculateInitialAutofills();
  }

  filterForms(value) {
    filledForm.clear();
    allForms.forEach((action) {
      filledForm.addIf(action.surveyId == value, action);
    });
  }

  getAssignedVillage() async {
    var responseVillage = await ApiServices().getData(
      url: "${ApiEndPoint.assignedVillageWardData}",
    );
    log(responseVillage);
    assignedVillageWardModel.value = AssignedVillageWardModel.fromJson(
      json.decode(responseVillage),
    );
    print(assignedVillageWardModel.value.data?.villages?.length);
    if (assignedVillageWardModel.value.data?.villages?.length != 0 &&
        assignedVillageWardModel.value.data?.villages?.length != null) {
      villageStored.value =
          assignedVillageWardModel.value.data?.villages?[0].id;
      if (categoryList.length != 0) {
        storedCategory.value = categoryList[1].id;
        // if(categoryList[0].name=="rural")
        //   {
        //
        //   }else if(categoryList[0].name=="urban")
        //     {
        //
        //     }
        // // await getUrbanData(storedCategory.value);
      }
    }
  }

  getAssignedWard() async {
    var responseWard = await ApiServices().getData(
      url: "${ApiEndPoint.assignedWardWards}",
    );

    wardListDataModel.value = WardListDataModel.fromJson(
      json.decode(responseWard),
    );
    log(responseWard);
    print(wardListDataModel.value.data?.wards?.length);
    if (wardListDataModel.value.data?.wards?.length != 0 &&
        wardListDataModel.value.data?.wards?.length != null) {
      wardStored.value = wardListDataModel.value.data?.wards?[0].id;
      if (categoryList.length != 0) {
        storedCategory.value = categoryList[0].id;
      }
    }
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

      // 🔄 Trigger autofill recalculation for fields that depend on this field
      _recalculateAutofillFields(id);

      answers.refresh();
      updateProgress(); // 🔁 Recalculate progress every time
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
    final String ruleVal = rule.dependsValue?.toString() ?? "";

    bool listContainsValue(List<dynamic> values) {
      return values.any((element) => element?.toString() == ruleVal);
    }

    switch (rule.conditionType) {
      case 'equals':
        if (depVal is List) {
          return depVal.isNotEmpty && listContainsValue(depVal);
        }
        return depVal != null &&
            depVal.toString().isNotEmpty &&
            depVal.toString() == ruleVal;
      case 'not_equals':
        if (depVal == null) return true;
        if (depVal is List) {
          return !listContainsValue(depVal);
        }
        return depVal.toString() != ruleVal;
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
    if (q.rules.isEmpty) return true;

    // If dependencies exist but none answered yet -> show by default
    final dependentRules = q.rules.where((r) => r.dependsOn != null).toList();
    if (dependentRules.isNotEmpty) {
      final anyDependencyAnswered = dependentRules.any((r) {
        final depAns = answers.firstWhereOrNull((a) => a.id == r.dependsOn);
        final value = depAns?.answer;
        if (value == null) return false;
        if (value is List) return value.isNotEmpty;
        return value.toString().isNotEmpty;
      });

      if (!anyDependencyAnswered) {
        return true;
      }
    }

    // 1) if any hide rule is matched -> hide immediately
    for (final r in q.rules.where((r) => r.action == 'hide')) {
      if (_evaluateRule(r)) {
        return false;
      }
    }

    // 2) if show rules exist -> visible only if at least one evaluates true
    final showRules = q.rules.where((r) => r.action == 'show').toList();
    if (showRules.isNotEmpty) {
      return showRules.any(_evaluateRule);
    }

    // 3) No show rules, no hide rules matched -> visible
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
    //TODO uncomenct for label validation remove
    // if (q.type == "label" && q.childrens.length != 0) {
    // } else

    if (q.isRequired) {
      if (q.type == 'checkbox') {
        final List sel = (ans?.answer ?? []).cast<dynamic>();
        final min = q.minSelect ?? 0;
        final max = q.maxSelect ?? q.options.length;
        if (sel.length < min) {
          Get.snackbar(
            "Missing",
            "Please select at least $min options for '${q.label}'.",

            titleText: Text(
              "Missing",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            messageText: Text(
              "Please select at least $min options for '${q.label}'.",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
          return false;
        }
        if (sel.length > max) {
          Get.snackbar(
            "Missing",
            "Please select at most $max options for '${q.label}'.",
            titleText: Text(
              "Missing",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            messageText: Text(
              "Please select at most $max options for '${q.label}'.",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
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
            titleText: Text(
              "Missing",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            messageText: Text(
              "Please provide answer for '${q.label}'.",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
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
              titleText: Text(
                "Too short",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              messageText: Text(
                "Answer for '${q.label}' must be at least $min characters.",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
            );
            return false;
          }
          if (value.length > max) {
            Get.snackbar(
              "Too long",
              "Answer for '${q.label}' must be no more than $max characters.",
              titleText: Text(
                "Too long",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              messageText: Text(
                "Answer for '${q.label}' must be no more than $max characters.",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
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

  submit(context) async {
    if (!validateForm()) return;

    final result = <Map<String, dynamic>>[];
    for (final q in questions) {
      _collectAnswers(q, result);
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Image.asset(
            "assets/images/splashLoader.gif",
            height: 25.w,
            width: 25.w,
            fit: BoxFit.fill,
          ),
        );
      },
    );

    try {
      final authUserData = {
        "url": ApiEndPoint.formSubmit,
        "village_id": storedCategory.value.toString() == "2"
            ? villageStored.value.toString()
            : "",
        "ward_id": storedCategory.value.toString() == "1"
            ? wardStored.value.toString()
            : "",
        "form_id": formId.toString(), // encode once here
        "answers": result,
      };

      log("📤 Request Data: ${jsonEncode(authUserData)}");

      var response = await ApiServices().uploadFormDataWithFiles(
        url: ApiEndPoint.formSubmit,
        villageId: storedCategory.value.toString() == "2"
            ? villageStored.value.toString()
            : "",
        wardId: storedCategory.value.toString() == "1"
            ? wardStored.value.toString()
            : "",
        formId: formId.toString(),
        answers: result, // encode once here
      );
      var datas = jsonDecode(response);
      if (datas["status"] == 201) {
        CommonWidgets().showSnackBar(
          "Message",
          datas["message"],
          Colors.green,
          Colors.white,
        );
        Navigator.pop(context);
      } else {
        CommonWidgets().showSnackBar(
          "Message",
          datas["message"],
          Colors.red,
          Colors.white,
        );
      }
      print("✅ Response: $response");
    } catch (e) {
      print("❌ Error submitting form: $e");
    }
    Navigator.pop(context);
    debugPrint("✅ Submitted Answers => $result");
    // Get.snackbar(
    //   "Success",
    //   "Form submitted successfully!",
    //   backgroundColor: Colors.green,
    //   colorText: Colors.white,
    // );
  }

  void _collectAnswers(QuestionModel q, List<Map<String, dynamic>> list) {
    if (!shouldShowQuestion(q)) return;
    final ans = answers.firstWhereOrNull((a) => a.id == q.id);
    if (ans != null && ans.answer != null && ans.answer.toString().isNotEmpty) {
      list.add({"id": q.id, "answer": ans.answer, "type": q.type});
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
      final formula = _getFormulaString(q.autofill);
      if (formula == null) continue;
      final fieldIds = _extractFormulaFieldIds(formula);
      if (fieldIds.contains(updatedFieldId)) {
        _evaluateAutofill(q);
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
    final formula = _getFormulaString(q.autofill);
    if (formula == null) return;

    final targetAnswer = answers.firstWhereOrNull((a) => a.id == q.id);
    if (targetAnswer == null) return;

    final evaluator = FormulaEvaluator(valueResolver: _resolveFormulaReference);

    try {
      final result = evaluator.evaluate(formula);
      // Only update if autofill succeeds
      targetAnswer.answer = _normalizeAutofillValue(result, q);
    } on FormulaMissingDependencyException {
      // If autofill fails due to missing dependencies, keep the existing value (default_value)
      // Don't change the answer at all - preserve default_value
      debugPrint(
        'Autofill formula for field ${q.id} failed: missing dependencies. Keeping existing value.',
      );
    } catch (e) {
      debugPrint('Error evaluating autofill formula for ${q.id}: $e');
      // On error, preserve existing value (default_value) - don't change it
    }

    answers.refresh();
    updateProgress();
  }

  /// Parse a value to a number
  num? _parseToNumber(dynamic value) {
    if (value is num) return value;
    if (value is bool) return value ? 1 : 0;
    if (value is String) {
      final cleaned = value.trim().replaceAll(RegExp(r'[^\d.-]'), '');
      return num.tryParse(cleaned);
    }
    return null;
  }

  void _applyPrefilledAnswers(List<QuestionModel> qs) {
    void assignValues(List<QuestionModel> questions) {
      for (final q in questions) {
        final value = _extractPrefilledValue(q);
        if (value != null) {
          final ans = answers.firstWhereOrNull((a) => a.id == q.id);
          if (ans != null) {
            ans.answer = value;
          }
        }
        if (q.childrens.isNotEmpty) {
          assignValues(q.childrens);
        }
      }
    }

    assignValues(qs);
    answers.refresh();
    updateProgress();
  }

  dynamic _extractPrefilledValue(QuestionModel question) {
    return _normalizePrefillValue(question, question.answerPayload);
  }

  dynamic _normalizePrefillValue(QuestionModel question, dynamic payload) {
    if (payload == null) return null;

    if (payload is List) {
      if (payload.isEmpty) return null;
      final normalized = payload
          .map((item) => _normalizePrefillValue(question, item))
          .where((value) => value != null)
          .toList();
      if (normalized.isEmpty) return null;

      if (question.type == 'checkbox') {
        final flattened = normalized
            .expand((value) => value is List ? value : [value])
            .map(_coerceToInt)
            .whereType<int>()
            .toList();
        return flattened.isEmpty ? null : flattened;
      }

      return normalized.first;
    }

    if (payload is Map<String, dynamic>) {
      if (question.type == 'file') {
        final path = (payload['path'] ?? payload['url'])?.toString();
        if (path == null || path.trim().isEmpty) return null;
        return path;
      }

      final value = payload['value'];
      return _normalizePrefillScalar(question, value);
    }

    return _normalizePrefillScalar(question, payload);
  }

  dynamic _normalizePrefillScalar(QuestionModel question, dynamic value) {
    if (value == null) return null;

    switch (question.type) {
      case 'checkbox':
        final list = value is List ? value : [value];
        final normalized = list.map(_coerceToInt).whereType<int>().toList();
        return normalized.isEmpty ? null : normalized;
      case 'radio':
      case 'select':
        final parsed = _parseToNumber(value);
        return parsed?.toInt();
      case 'number':
        if (value is num) return _formatNumber(value);
        final parsed = _parseToNumber(value);
        return parsed != null ? _formatNumber(parsed) : value.toString();
      case 'file':
        final path = value.toString();
        return path.trim().isEmpty ? null : path;
      default:
        return value.toString();
    }
  }

  int? _coerceToInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  /// Set default values for fields with is_default: 1 options or default_value
  void _setDefaultValues() {
    final allQuestions = _getAllQuestions(questions);
    for (final q in allQuestions) {
      // Skip if field already has a value
      final existingAnswer = answers.firstWhereOrNull((a) => a.id == q.id);
      if (existingAnswer?.answer != null) continue;

      dynamic defaultValue;

      // Handle radio and select fields - set default if one option has is_default: 1
      if (q.type == 'radio' || q.type == 'select') {
        final defaultOption = q.options.firstWhereOrNull(
          (opt) => opt.isDefault == 1,
        );
        if (defaultOption != null) {
          // Store the id (not code) to match what UI components expect
          defaultValue = defaultOption.id;
        }
      }
      // Handle checkbox fields - add all options with is_default: 1
      else if (q.type == 'checkbox') {
        final defaultOptions = q.options
            .where((opt) => opt.isDefault == 1)
            .map((opt) => opt.id)
            .toList();
        if (defaultOptions.isNotEmpty) {
          defaultValue = defaultOptions;
        }
      }
      // Handle fields with default_value (number, input, etc.)
      // Set default_value first, autofill will override if it can evaluate successfully
      if (q.defaultValue != null && defaultValue == null) {
        defaultValue = q.defaultValue;
      }

      // Set the value directly without triggering autofill recalculation
      if (defaultValue != null) {
        final ans = answers.firstWhereOrNull((a) => a.id == q.id);
        if (ans != null) {
          if (defaultValue is List && defaultValue.isEmpty) {
            ans.answer = null;
          } else if (defaultValue == null ||
              (defaultValue is String && defaultValue.trim().isEmpty)) {
            ans.answer = null;
          } else {
            ans.answer = defaultValue;
          }
        }
      }
    }
    // Refresh answers after setting all defaults
    answers.refresh();
  }

  /// Calculate initial autofill values when questions are loaded
  void _calculateInitialAutofills() {
    final allQuestions = _getAllQuestions(questions);
    for (final q in allQuestions) {
      if (_getFormulaString(q.autofill) != null) {
        final currentAns = answers.firstWhereOrNull((a) => a.id == q.id);
        if (currentAns?.answer == null) {
          // Try to evaluate autofill only when no response is already stored
          _evaluateAutofill(q);
        }
      }
    }
  }

  String? _getFormulaString(AutofillModel? autofill) {
    if (autofill == null) return null;
    if (autofill.plainFormula != null &&
        autofill.plainFormula!.trim().isNotEmpty) {
      return autofill.plainFormula!;
    }
    if (autofill.formula != null && autofill.formula!.trim().isNotEmpty) {
      return autofill.formula!;
    }
    return null;
  }

  Set<int> _extractFormulaFieldIds(String formula) {
    final ids = <int>{};
    final regex = RegExp(r'\{(\d+)(?::[^}]*)?\}');
    for (final match in regex.allMatches(formula)) {
      final id = int.tryParse(match.group(1) ?? '');
      if (id != null) ids.add(id);
    }
    return ids;
  }

  dynamic _resolveFormulaReference(String token) {
    final idPart = token.split(':').first.trim();
    final fieldId = int.tryParse(idPart);
    if (fieldId == null) return null;
    final answer = answers.firstWhereOrNull((a) => a.id == fieldId);
    final value = answer?.answer;

    // Find the question to check if it's a radio/select/checkbox field
    final question = _getAllQuestions(
      questions,
    ).firstWhereOrNull((q) => q.id == fieldId);

    // For radio/select/checkbox fields, convert id to code for formula evaluation
    if (question != null &&
        (question.type == 'radio' ||
            question.type == 'select' ||
            question.type == 'checkbox')) {
      if (value is List) {
        if (value.isEmpty) return null;
        // Convert each id in the list to its corresponding code
        final codes = value.map((id) {
          final opt = question.options.firstWhereOrNull((o) => o.id == id);
          return opt?.code ?? id;
        }).toList();
        return codes.length == 1 ? codes.first : codes;
      } else if (value != null) {
        // Convert single id to code
        final opt = question.options.firstWhereOrNull((o) => o.id == value);
        return opt?.code ?? value;
      }
    }

    if (value is List) {
      if (value.isEmpty) return null;
      return value.length == 1 ? value.first : value;
    }
    return value;
  }

  dynamic _normalizeAutofillValue(dynamic value, QuestionModel question) {
    if (value == null) return null;

    switch (question.type) {
      case 'radio':
      case 'select':
        final numeric = _parseToNumber(value);
        return numeric?.toInt();
      case 'checkbox':
        // For checkbox, ensure we return a List<int>
        if (value is List) {
          return value
              .map((e) {
                if (e is int) return e;
                if (e is num) return e.toInt();
                return int.tryParse(e.toString());
              })
              .whereType<int>()
              .toList();
        }
        // If it's a boolean true, select all default options
        if (value is bool && value == true) {
          final defaultOptions = question.options
              .where((opt) => opt.isDefault == 1)
              .map((opt) => opt.id)
              .toList();
          return defaultOptions.isNotEmpty ? defaultOptions : null;
        }
        // If it's a single value, try to convert to int and return as list
        if (value is int) {
          return [value];
        }
        if (value is num) {
          return [value.toInt()];
        }
        final parsed = int.tryParse(value.toString());
        return parsed != null ? [parsed] : null;
      case 'number':
        if (value is num) {
          return _formatNumber(value);
        }
        final numeric = _parseToNumber(value);
        return numeric != null ? _formatNumber(numeric) : value.toString();
      default:
        if (value is num) return _formatNumber(value);
        return value.toString();
    }
  }

  String _formatNumber(num value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    }
    return value
        .toStringAsFixed(4)
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');
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
  final dynamic defaultValue;
  final dynamic answerPayload;

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
    this.defaultValue,
    this.answerPayload,
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
      defaultValue: json["default_value"],
      answerPayload: json["answers"],
    );
  }
}

class OptionModel {
  final int id;
  final int? code;
  final String label;
  final int isDefault;

  OptionModel({
    required this.id,
    required this.label,
    this.code,
    this.isDefault = 0,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json["id"],
      label: json["label"] ?? "",
      code: json["code"],
      isDefault: json["is_default"] ?? 0,
    );
  }
}

class FilledFormModel {
  final int id;
  final String? name;
  final int? surveyId;

  FilledFormModel({
    required this.id,
    required this.name,
    required this.surveyId,
  });

  factory FilledFormModel.fromJson(Map<String, dynamic> json) {
    return FilledFormModel(
      id: json["id"],
      name: json["name"] ?? "",
      surveyId: json["survey_id"],
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
  final String? formula;
  final String? type;

  bool get hasFormula {
    return (plainFormula?.trim().isNotEmpty ?? false) ||
        (formula?.trim().isNotEmpty ?? false);
  }

  AutofillModel({
    this.sourceFormId,
    this.plainFormula,
    this.formula,
    this.type,
  });

  factory AutofillModel.fromJson(Map<String, dynamic> json) {
    return AutofillModel(
      sourceFormId: json["source_form_id"]?.toString(),
      plainFormula: json["plain_formula"]?.toString(),
      formula: json["formula"]?.toString(),
      type: json["type"]?.toString(),
    );
  }
}
