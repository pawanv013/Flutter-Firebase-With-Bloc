import 'package:firebase_flutter/screens/google_sign_in/sign_in_google_screen.dart';
import 'package:firebase_flutter/screens/notification/notification_screen.dart';
import 'package:firebase_flutter/screens/phone_auth/mobile_screen.dart';
import 'package:flutter/material.dart';

import 'email_password/login_screen.dart';

class ModuleList extends StatelessWidget {
  const ModuleList({Key? key}) : super(key: key);
  static const String id = 'module_list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Card(
              child: ListTile(
                onTap: () => Navigator.pushNamed(context, LoginScreen.id),
                leading: Icon(Icons.mail),
                title: Text('Email Password Authentication'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () => Navigator.pushNamed(context, PhoneAuthScreen.id),
                leading: Icon(Icons.phone_android),
                title: Text('Firebase Phone Auth'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () =>
                    Navigator.pushNamed(context, NotificationScreen.id),
                leading: Icon(Icons.notifications),
                title: Text('Firebase Notification'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () =>
                    Navigator.pushNamed(context, SignInGoogleScreen.id),
                leading: Icon(Icons.mail_outline),
                title: Text('Sign In with Google'),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
