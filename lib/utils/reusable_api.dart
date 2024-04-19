import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/provider/categories.dart';
import 'package:hakibah/provider/user_provider.dart';
import 'package:hakibah/utils/api_client.dart';
import "package:http/http.dart" as http;

Future<http.Response> getCategories(WidgetRef ref, BuildContext context) async {
  var response = await apiClient(apiEndpoint: "get-category", context: context);
  if (response.statusCode == 200) {
    var decode = jsonDecode(response.body);
    ref.read(categoriesProvider.notifier).setCategories(decode["data"]);
  }
  return response;
}

Future<http.Response> getUserApi(WidgetRef ref, BuildContext context) async {
  var response =
      await apiClient(apiEndpoint: "ecommerce/customer", context: context);
  if (response.statusCode == 200) {
    var decode = jsonDecode(response.body);
    ref.read(userProvider.notifier).setUser(decode["data"]);
  }
  return response;
}
