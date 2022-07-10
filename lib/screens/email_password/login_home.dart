import 'package:firebase_flutter/screens/email_password/bloC/profileCubit/profile_cubit.dart';
import 'package:firebase_flutter/screens/email_password/bloC/profileCubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginHome extends StatelessWidget {
  const LoginHome({Key? key}) : super(key: key);
  static const String id = 'login_home';
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _fullName = TextEditingController();
    TextEditingController _age = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Email-Passwords'),
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: BlocConsumer<ProfileCubit, ProfileState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () async {
                          BlocProvider.of<ProfileCubit>(context)
                              .setSelectedImage();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          backgroundImage:
                              (BlocProvider.of<ProfileCubit>(context).profile !=
                                      null)
                                  ? FileImage(
                                      BlocProvider.of<ProfileCubit>(context)
                                          .profile!)
                                  : null,
                          radius: 40,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: TextFormField(
                    controller: _fullName,
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return 'Enter Full Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Full Name'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _age,
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return 'Enter Age';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Enter Age'),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: BlocConsumer<ProfileCubit, ProfileState>(
                      listener: (context, state) {
                        if (state is ProfileSavelState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(state.saveSuccessMessage),
                            ),
                          );
                        } else if (state is ProfileSaveErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(state.saveErrorMessage),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is ProfileLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<ProfileCubit>(context)
                                    .submitProfileDetail(
                                        _fullName.text, _age.text);
                              }
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
