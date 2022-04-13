import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/controller/NavigationController.dart';

const String BASE_URL = 'http://ciam.notionprojects.tech/api/patient/';
const String Token = '123456789';

void success(
  BuildContext context,
  dynamic value,
) {
  Pop(context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      value['message'].toString(),
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
  ));
}

void compareresponsedata(dynamic response, BuildContext context) {
  if (response['status']) {
    success(context, response);
  } else {
    failure(context, response);
  }
}

void failure(
  BuildContext context,
  dynamic value,
) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      value['message'].toString(),
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
  ));
}

Future PostData({
  required String PARAM_URL,
  required Map params,
}) async {
  var response = await http.post(Uri.parse(BASE_URL + PARAM_URL), body: params);
  print(response.body);
  var Response = jsonDecode(response.body);
  print('----------->' + Response.toString());

  return Response;
}

Future<String> downloadFile(String url, String fileName, String dir) async {
  print('something');
  HttpClient httpClient = new HttpClient();
  File file;
  String filePath = '';
  String myUrl = '';

  try {
    myUrl = url + '/' + fileName;
    var request = await httpClient.getUrl(Uri.parse(myUrl));
    var response = await request.close();
    if (response.statusCode == 200) {
      var bytes = await consolidateHttpClientResponseBytes(response);
      filePath = '$dir/$fileName';
      file = File(filePath);
      await file.writeAsBytes(bytes);
    } else
      filePath = 'Error code: ' + response.statusCode.toString();
  } catch (ex) {
    filePath = 'Can not fetch url';
  }

  return filePath;
}

Future PostDataWithImage(
    {required String PARAM_URL,
    required Map<String, String> params,
    required String imagePath,
    required String imageparamName}) async {
  var request =
      await http.MultipartRequest('POST', Uri.parse(BASE_URL + PARAM_URL));
  request.fields.addAll(params);
  var pic = await http.MultipartFile.fromPath(imageparamName, imagePath);
  request.files.add(pic);
  var responseData = await request.send();
  var response = await responseData.stream.toBytes();
  var responseString = String.fromCharCodes(response);
  print('----------->' + responseString.toString());
  var finalresponse = jsonDecode(responseString);
  return finalresponse;
}

Future Getdata({required String PARAM_URL}) async {
  var response = await http.get(
    Uri.parse(BASE_URL + PARAM_URL),
  );
  print(response.body);
  var Response = jsonDecode(response.body);
  return Response;
}
