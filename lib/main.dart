import 'package:flutter/material.dart';
import 'package:flutter_api_challenge/config/repositories.dart';
import 'package:flutter_api_challenge/modules/core/core_screen.dart';

void main() {
  Repositories.register();
  runApp(const ApiChallengeApp());
}

class ApiChallengeApp extends StatelessWidget {
  const ApiChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reqres API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CoreScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
