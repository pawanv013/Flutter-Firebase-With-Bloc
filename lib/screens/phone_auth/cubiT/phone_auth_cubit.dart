import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  PhoneAuthCubit() : super(PhoneAuthInitialState());
  late String _verificationId;
  Future<void> sendAuthOtp(String phoneNumber) async {
    emit(PhoneAuthLoadingState());
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredetial) {
          signInWithOtp(phoneAuthCredetial);
        },
        verificationFailed: (error) {
          emit(PhoneAuthErrorState(error.message.toString()));
        },
        codeSent: (verifiedId, resendToken) {
          _verificationId = verifiedId;
          emit(PhoneAuthCodeSentState());
        },
        codeAutoRetrievalTimeout: (verifiedId) {
          _verificationId = verifiedId;
        });
  }

  Future<void> signInWithOtp(PhoneAuthCredential phoneAuthCredetial) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(phoneAuthCredetial);
      if (userCredential.user != null) {
        emit(PhoneAuthLoggedInState(userCredential.user!));
      }
    } on FirebaseException catch (e) {
      emit(PhoneAuthErrorState(e.message.toString()));
    }
  }

  Future<void> verifyOtp(String otp) async {
    emit(PhoneAuthLoadingState());
    PhoneAuthCredential phoneAuthCredential =
        await PhoneAuthProvider.credential(
            verificationId: _verificationId, smsCode: otp);
    signInWithOtp(phoneAuthCredential);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    emit(PhoneAuthLoggedOutState());
  }
}
