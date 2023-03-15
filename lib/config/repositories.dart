import 'package:flutter_api_challenge/data/repositories/users_repository.dart';
import 'package:get_it/get_it.dart';

class Repositories {
  static void register() {
    GetIt.I.registerSingleton<UsersRepository>(UsersRepository());
  }
}
