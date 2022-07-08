import 'package:firebase_flutter/screens/email_password/bloC/loginBloC/login_event.dart';
import 'package:firebase_flutter/screens/email_password/login_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloC/loginBloC/login_bloc.dart';
import 'bloC/loginBloC/login_state.dart';
import 'singup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _emailVal = TextEditingController();
    TextEditingController _passwordVal = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              child: Column(
                children: [
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginFormErrorState) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Text(state.loginFormErrorMessage),
                        );
                      } else {
                        return SizedBox(height: 0, width: 0);
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: _emailVal,
                      onChanged: (value) {
                        BlocProvider.of<LoginBloc>(context).add(
                            LoginTextChangeEvent(
                                _emailVal.text, _passwordVal.text));
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter user name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter email address',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordVal,
                      onChanged: (value) {
                        BlocProvider.of<LoginBloc>(context).add(
                            LoginTextChangeEvent(
                                _emailVal.text, _passwordVal.text));
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccessState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(state.loginSuccessMessage),
                            ),
                          );
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacementNamed(context, LoginHome.id);
                        } else if (state is LoginErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(state.loginErrorMessage),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (state is LoginFormValidState) {
                                          BlocProvider.of<LoginBloc>(context)
                                              .add(
                                            LoginSubmitEvent(_emailVal.text,
                                                _passwordVal.text),
                                          );
                                        }
                                        _formKey.currentState!.reset();
                                      }
                                    },
                                    child: Text('Login')),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, SingUpScreen.id);
                                    },
                                    child: Text('Sign Up')),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
