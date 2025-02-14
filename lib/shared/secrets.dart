// create pto token provider
// create secret token provider
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harmony_hub/auth/auth_provider.dart';
import 'package:harmony_hub/shared/infrastructure/dto/secret.dart';
import 'package:http/http.dart' as http;

Future<Secret> getSecretAsync(
    Ref ref, String secretName, String secretVersion) async {
  var authState = ref.read(authStateNotifierProvider);
  var accessToken = authState.credentials?.accessToken ?? '';

  if (accessToken.isEmpty) {
    throw Exception('Access token is empty');
  }

  final response = await http.get(
      Uri.parse(
          'https://token-exchange-967069270876.asia-southeast1.run.app?secretName=$secretName&secretVersion=$secretVersion'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'});

  final json = jsonDecode(response.body) as Map<String, dynamic>;

  return Secret.fromJson(json);
}
