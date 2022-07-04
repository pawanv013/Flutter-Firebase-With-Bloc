import 'package:firebase_flutter/screens/email_password/login_screen.dart';
import 'package:firebase_flutter/screens/module_list.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ModuleList.id,
      routes: {
        ModuleList.id: (context) => ModuleList(),
        LoginScreen.id: (context) => LoginScreen(),
      },
    );
  }
}
