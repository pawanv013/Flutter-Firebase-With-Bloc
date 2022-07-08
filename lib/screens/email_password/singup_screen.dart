import 'package:firebase_flutter/screens/email_password/bloC/signUpBloC/signup_bloc.dart';
import 'package:firebase_flutter/screens/email_password/bloC/signUpBloC/signup_event.dart';
import 'package:firebase_flutter/screens/email_password/bloC/signUpBloC/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({Key? key}) : super(key: key);
  static const String id = 'signup_screen';
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _conformpassword = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        if (state is SignUpFormErrorState) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Text(state.errorMessage),
                          );
                        } else {
                          return SizedBox(
                            height: 0,
                            width: 0,
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: _email,
                        onChanged: (value) {
                          BlocProvider.of<SignUpBloc>(context).add(
                              SignUpTextValueChangeEvent(_email.text,
                                  _password.text, _conformpassword.text));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter email address',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        obscureText: true,
                        controller: _password,
                        onChanged: (value) {
                          BlocProvider.of<SignUpBloc>(context).add(
                              SignUpTextValueChangeEvent(_email.text,
                                  _password.text, _conformpassword.text));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        obscureText: true,
                        controller: _conformpassword,
                        onChanged: (value) {
                          BlocProvider.of<SignUpBloc>(context).add(
                              SignUpTextValueChangeEvent(_email.text,
                                  _password.text, _conformpassword.text));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Conform password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Conform password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: BlocConsumer<SignUpBloc, SignUpState>(
                        listener: (context, state) {
                          if (state is SignUpErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(state.signUpErrorMessage),
                              ),
                            );
                          }
                          if (state is SignUpSuccessState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(state.signUpSuccessMessage),
                              ),
                            );
                            _email.clear();
                            _password.clear();
                            _conformpassword.clear();
                            _formKey.currentState!.reset();
                          }
                        },
                        builder: (context, state) {
                          if (state is SignUpFormLoadingState) {
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
                                          if (state is SignUpFormValidState) {
                                            BlocProvider.of<SignUpBloc>(context)
                                                .add(SignUpSubmitEvent(
                                                    _email.text,
                                                    _password.text,
                                                    _conformpassword.text));
                                          }
                                        }
                                      },
                                      child: Text('Sign Up')),
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
                                        Navigator.pop(context);
                                      },
                                      child: Text('Back To Login')),
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
      ),
    );
  }
}
