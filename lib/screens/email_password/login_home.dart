import 'package:flutter/material.dart';

class LoginHome extends StatelessWidget {
  const LoginHome({Key? key}) : super(key: key);
  static const String id = 'login_home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Email-Passwords'),
      ),
      body: SafeArea(
          child: Center(
        child: Text('Login success'),
      )),
    );
  }
}
