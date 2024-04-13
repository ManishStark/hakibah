import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hakibah/constatns.dart';
import 'package:http/http.dart' as http;

Future<http.Response> apiClient(
    {required String apiEndpoint,
    required BuildContext context,
    String method = 'GET',
    bool isToken = true,
    var requestBody,
    Map<String, dynamic>? queryParams}) async {
  var response = await _makeRequest(
      apiEndpoint: apiEndpoint,
      method: method,
      queryParams: queryParams,
      requestBody: requestBody,
      isToken: isToken);

  return response;
}

Future<http.Response> _makeRequest(
    {required String apiEndpoint,
    String method = "GET",
    bool isToken = true,
    var requestBody,
    Map<String, dynamic>? queryParams}) async {
  Uri uri = Uri.parse("$apiURL$apiEndpoint");
  if (queryParams != null && queryParams.isNotEmpty) {
    uri = uri.replace(queryParameters: queryParams);
  }
  String authToken = await getToken();
  String? requestBodyJson;
  if (requestBody != null && requestBody.isNotEmpty) {
    requestBodyJson = jsonEncode(requestBody);
  }

  http.Response response;

  switch (method) {
    case 'GET':
      response = await http.get(
        uri,
        headers: {if (isToken) 'Authorization': 'Bearer $authToken'},
      );
      break;
    case 'POST':
      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
          if (isToken) 'Authorization': 'Bearer $authToken',
        },
        body: requestBodyJson,
      );
      break;
    case 'DELETE':
      response = await http.delete(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
          if (isToken) 'Authorization': 'Bearer $authToken',
        },
        body: requestBodyJson,
      );
      break;
    case 'PUT':
      response = await http.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
          if (isToken) 'Authorization': 'Bearer $authToken',
        },
        body: requestBodyJson,
      );
      break;
    default:
      throw Exception("Unsupported HTTP method: $method");
  }

  return response;
}
