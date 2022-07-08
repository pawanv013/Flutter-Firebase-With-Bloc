import 'package:firebase_flutter/screens/email_password/bloC/signUpBloC/signup_bloc.dart';
import 'package:firebase_flutter/screens/email_password/login_home.dart';
import 'package:firebase_flutter/screens/email_password/login_screen.dart';
import 'package:firebase_flutter/screens/email_password/singup_screen.dart';
import 'package:firebase_flutter/screens/module_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/email_password/bloC/loginBloC/login_bloc.dart';
import 'screens/email_password/bloC/signUpBloC/signup_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(
          create: (BuildContext context) => SignUpBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: ModuleList.id,
        routes: {
          ModuleList.id: (context) => ModuleList(),
          LoginScreen.id: (context) => LoginScreen(),
          SingUpScreen.id: (context) => SingUpScreen(),
          LoginHome.id: (context) => LoginHome(),
        },
      ),
    );
  }
}
