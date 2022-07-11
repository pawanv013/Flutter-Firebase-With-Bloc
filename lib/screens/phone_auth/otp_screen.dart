import 'package:firebase_flutter/screens/email_password/login_home.dart';
import 'package:firebase_flutter/screens/phone_auth/cubiT/phone_auth_cubit.dart';
import 'package:firebase_flutter/screens/phone_auth/cubiT/phone_auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneAuthOtpScreen extends StatelessWidget {
  const PhoneAuthOtpScreen({Key? key}) : super(key: key);
  static const String id = 'phone_auth_otp';
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _otp = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Auth Otp'),
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == '' || value!.isEmpty) {
                      return 'Enter 6 digit Otp';
                    }
                    return null;
                  },
                  controller: _otp,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter 6 Digit Otp'),
                ),
                SizedBox(height: 20),
                BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
                  listener: (context, state) {
                    if (state is PhoneAuthErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(state.phoneAuthErrorMessage),
                        ),
                      );
                    } else if (state is PhoneAuthLoggedInState) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushNamed(context, LoginHome.id);
                    }
                  },
                  builder: (context, state) {
                    if (state is PhoneAuthLoadingState) {
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
                                  BlocProvider.of<PhoneAuthCubit>(context)
                                      .verifyOtp(_otp.text);
                                }
                              },
                              child: Text('Get Otp'),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
