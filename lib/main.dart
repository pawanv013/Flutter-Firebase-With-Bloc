import 'package:firebase_flutter/screens/email_password/bloC/profileCubit/profile_cubit.dart';
import 'package:firebase_flutter/screens/email_password/bloC/signUpBloC/signup_bloc.dart';
import 'package:firebase_flutter/screens/email_password/login_home.dart';
import 'package:firebase_flutter/screens/email_password/login_screen.dart';
import 'package:firebase_flutter/screens/email_password/singup_screen.dart';
import 'package:firebase_flutter/screens/module_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/screens/notification/notification_screen.dart';
import 'package:firebase_flutter/screens/notification/services/notification_service.dart';
import 'package:firebase_flutter/screens/phone_auth/cubiT/phone_auth_cubit.dart';
import 'package:firebase_flutter/screens/phone_auth/mobile_screen.dart';
import 'package:firebase_flutter/screens/phone_auth/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/email_password/bloC/loginBloC/login_bloc.dart';
import 'screens/email_password/bloC/signUpBloC/signup_bloc.dart';
import 'screens/google_sign_in/cubiT/google_cubit.dart';
import 'screens/google_sign_in/sign_in_google_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.initializeNotification();
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
        BlocProvider<ProfileCubit>(
          create: (BuildContext context) => ProfileCubit(),
        ),
        BlocProvider<GoogleSignInCubit>(
          create: (BuildContext context) => GoogleSignInCubit(),
        ),
        BlocProvider<PhoneAuthCubit>(
          create: (BuildContext context) => PhoneAuthCubit(),
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
          NotificationScreen.id: (context) => NotificationScreen(),
          SignInGoogleScreen.id: (context) => SignInGoogleScreen(),
          PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
          PhoneAuthOtpScreen.id: (context) => PhoneAuthOtpScreen(),
        },
      ),
    );
  }
}
