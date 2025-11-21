import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssinfra/services/apiEndPoint.dart';
import 'package:flutter/material.dart';
import '../utils/commonWidgets.dart';

class ApiServices {
  Future getData({String? url}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = await prefs.getString("tokenValue");
    print("${ApiEndPoint.endPoint}$url");
    var res = await http.get(
      Uri.parse("${ApiEndPoint.endPoint}$url"),
      headers: {
        "Accept": "application/json",
        'Authorization': "Bearer $apiToken",
      },
    );
    return res.body;
  }

  Future getPdf({String? url}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = await prefs.getString("tokenValue");

    /// 🔥 1. API CALL (Use your API below)
    final response = await http.get(
      Uri.parse("${ApiEndPoint.endPoint}$url"),
      headers: {
        "Accept": "application/json",
        'Authorization': "Bearer $apiToken",
      },
    );

    // if (response.statusCode != 200) {
    //   CommonWidgets().showSnackBar(
    //     "Message",
    //     "Failed",
    //     Colors.green,
    //     Colors.white,
    //   );
    // }

    /// 🔥 2. CHECK RESPONSE TYPE: Base64 or Byte List
    Uint8List pdfBytes;

    if (response.headers['content-type']!.contains("application/pdf")) {
      // API gives raw PDF bytes
      pdfBytes = response.bodyBytes;
    } else {
      // API gives base64 string
      pdfBytes = base64Decode(response.body.toString());
    }

    /// 🔥 3. SAVE PDF TO TEMP DIRECTORY
    final dir = await getTemporaryDirectory();
    final file = File("${dir.path}/downloaded_file.pdf");
    await file.writeAsBytes(pdfBytes);

    print("PDF Saved at: ${file.path}");

    /// 🔥 4. OPEN PDF
    await OpenFile.open(file.path);
    return response.statusCode;
  }

  Future postData({String? url, dynamic data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = await prefs.getString("tokenValue");
    print("${ApiEndPoint.endPoint}$url");
    var res = await http.post(
      Uri.parse("${ApiEndPoint.endPoint}$url"),
      body: data,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': "Bearer $apiToken",
      },
    );
    return res.body;
  }

  Future uploadDataWithFiles({
    required String url,
    required Map<String, String> fields,
    required Map<String, File?> files,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString("tokenValue");
    print("${ApiEndPoint.endPoint}$url");
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${ApiEndPoint.endPoint}$url"),
    );

    request.headers.addAll({
      "Accept": "application/json",
      "Authorization": "Bearer $apiToken",
    });

    // add form fields
    fields.forEach((key, value) {
      request.fields[key] = value;
    });

    // add file fields
    for (var entry in files.entries) {
      if (entry.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(entry.key, entry.value!.path),
        );
      }
    }

    var response = await request.send();
    return await response.stream.bytesToString();
  }

  Future uploadDataWithFilesPut({
    required String url,
    required Map<String, String> fields,
    required Map<String, File?> files,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString("tokenValue");
    print("${ApiEndPoint.endPoint}$url");
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse("${ApiEndPoint.endPoint}$url"),
    );

    request.headers.addAll({
      "Accept": "application/json",
      "Authorization": "Bearer $apiToken",
    });

    // add form fields
    fields.forEach((key, value) {
      request.fields[key] = value;
    });

    // add file fields
    for (var entry in files.entries) {
      if (entry.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(entry.key, entry.value!.path),
        );
      }
    }

    var response = await request.send();
    return await response.stream.bytesToString();
  }

  Future<String> uploadFormDataWithFiles({
    required String url,
    required int villageId,
    required String formId,
    required List<Map<String, dynamic>> answers,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString("tokenValue");
    print("${ApiEndPoint.endPoint}$url");
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${ApiEndPoint.endPoint}$url"),
    );

    request.headers.addAll({
      "Accept": "application/json",
      "Authorization": "Bearer $apiToken",
    });

    // ✅ Base fields
    request.fields["village_id"] = villageId.toString();
    request.fields["form_id"] = formId.toString();

    int index = 0;
    for (var answer in answers) {
      final id = answer["id"].toString();
      final type = answer["type"].toString();

      if (type == "file") {
        File file = File(answer["answer"]);
        if (await file.exists()) {
          // Add the actual file
          request.files.add(
            await http.MultipartFile.fromPath(
              'answers[$index][answer]', // dynamic name per index
              file.path,
            ),
          );

          // Add id & type
          request.fields['answers[$index][id]'] = id;
          request.fields['answers[$index][type]'] = type;
        }
      } else {
        // Non-file fields
        request.fields['answers[$index][id]'] = id;
        request.fields['answers[$index][answer]'] = answer["answer"].toString();
        request.fields['answers[$index][type]'] = type;
      }

      index++;
    }

    log("🟢 Request Fields: ${request.fields}");
    log("🟢 Files: ${request.files.map((f) => f.filename).toList()}");

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    log("🟢 Response: $responseBody");
    return responseBody;
  }
}
