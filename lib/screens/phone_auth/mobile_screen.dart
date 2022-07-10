import 'package:firebase_flutter/screens/phone_auth/cubiT/phone_auth_cubit.dart';
import 'package:firebase_flutter/screens/phone_auth/cubiT/phone_auth_state.dart';
import 'package:firebase_flutter/screens/phone_auth/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);
  static const String id = 'phone_auth_mobile';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _phoneNumber = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Auth Mobile'),
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == '' || value!.isEmpty) {
                        return 'Enter phone number';
                      }
                      return null;
                    },
                    controller: _phoneNumber,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter mobile number',
                    ),
                  ),
                  SizedBox(height: 20),
                  BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
                    listener: (context, state) {
                      if (state is PhoneAuthErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.phoneAuthErrorMessage)));
                      } else if (state is PhoneAuthCodeSentState) {
                        Navigator.pushNamed(context, PhoneAuthOtpScreen.id);
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
                                    String _phoneNo = '+91' + _phoneNumber.text;
                                    BlocProvider.of<PhoneAuthCubit>(context)
                                        .sendAuthOtp(_phoneNo);
                                    // Navigator.pushNamed(
                                    //     context, PhoneAuthOtpScreen.id);
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
        ),
      ),
    );
  }
}
