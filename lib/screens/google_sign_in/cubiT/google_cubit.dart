import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'google_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSingInState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInCubit() : super(GoogleSignInInitialState());
  late UserCredential userCredential;

  Future<void> googleSignIn() async {
    emit(GoogleSignInLoadingState());
    try {
      final googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        if (googleSignInAuthentication.idToken != null &&
            googleSignInAuthentication.accessToken != null) {
          userCredential = await _auth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleSignInAuthentication.idToken,
                accessToken: googleSignInAuthentication.accessToken),
          );
          emit(GoogleSignInSuccesslState('Sign In Success with google'));
        }
      }
    } on FirebaseException catch (e) {
      emit(GoogleSignInErrorState(e.message.toString()));
    }
  }
}
