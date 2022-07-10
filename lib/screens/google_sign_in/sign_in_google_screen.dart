import 'package:firebase_flutter/screens/email_password/login_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubiT/google_cubit.dart';
import 'cubiT/google_state.dart';

class SignInGoogleScreen extends StatelessWidget {
  const SignInGoogleScreen({Key? key}) : super(key: key);
  static const String id = 'google_sign_in';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn With Google'),
      ),
      body: SafeArea(
        child: BlocListener<GoogleSignInCubit, GoogleSingInState>(
          listener: (context, state) {
            if (state is GoogleSignInErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.signInErrorMessage),
                ),
              );
            } else if (state is GoogleSignInSuccesslState) {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushNamed(context, LoginHome.id);
            }
          },
          child: Center(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                child: Text('SignIn With Googles'),
                onPressed: () {
                  BlocProvider.of<GoogleSignInCubit>(context).googleSignIn();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
