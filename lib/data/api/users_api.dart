import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_api_challenge/data/api/api_constants.dart';
import 'package:flutter_api_challenge/data/models/user_created.dart';
import 'package:flutter_api_challenge/data/models/user_page.dart';

class UsersApi {
  static Future<UserPage> getUsers({
    required Dio client,
    required String query,
  }) async {
    try {
      final Response response = await client.get(ApiConstants.users(query));
      UserPage userPage = UserPage.fromJson(response.data);
      return userPage;
    } catch (error, stacktrace) {
      log('$error', name: 'getUsers', stackTrace: stacktrace, error: error);
      rethrow;
    }
  }

  static Future<UserCreated> createUser({
    required Dio client,
    required String name,
    required String job,
  }) async {
    try {
      final Response response = await client.post(
        ApiConstants.users(null),
        data: {
          "name": name,
          "job": job,
        },
      );
      UserCreated userCreated = UserCreated.fromJson(response.data);
      return userCreated;
    } catch (error, stacktrace) {
      log('$error', name: 'createUser', stackTrace: stacktrace, error: error);
      rethrow;
    }
  }
}
