import 'package:flutter/material.dart';
import 'package:flutter_api_challenge/modules/users/users_list/users_list_screen.dart';

class CoreScreen extends StatefulWidget {
  const CoreScreen({Key? key}) : super(key: key);

  @override
  State<CoreScreen> createState() => _CoreScreenState();
}

class _CoreScreenState extends State<CoreScreen> {
  @override
  Widget build(BuildContext context) {
    return const UsersListScreen();
  }
}
