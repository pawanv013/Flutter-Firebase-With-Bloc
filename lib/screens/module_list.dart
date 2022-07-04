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
                leading: Icon(Icons.mail),
                title: Text('Email Password Authentication'),
              ),
            )
          ],
        ),
      )),
    );
  }
}
