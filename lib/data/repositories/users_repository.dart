import 'package:dio/dio.dart';
import 'package:flutter_api_challenge/data/api/api_constants.dart';
import 'package:flutter_api_challenge/data/api/users_api.dart';
import 'package:flutter_api_challenge/data/models/user_created.dart';
import 'package:flutter_api_challenge/data/models/user_page.dart';
import 'package:flutter_api_challenge/util/helpers/query_builder.dart';

class UsersRepository {
  final Dio _client = ApiConstants.getDioClient();

  Future<UserPage> getUsers({
    required int pageIndex,
  }) async {
    UserPage users = await UsersApi.getUsers(
      client: _client,
      query: QueryBuilder.generateQueryWithMap(
        params: {
          'page': pageIndex,
        },
      ),
    );
    return users;
  }

  Future<UserCreated> createUser({
    required String name,
    required String job,
  }) async {
    UserCreated userCreated = await UsersApi.createUser(
      client: _client,
      name: name,
      job: job,
    );
    return userCreated;
  }
}
