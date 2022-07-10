abstract class GoogleSingInState {}

class GoogleSignInInitialState extends GoogleSingInState {}

class GoogleSignInErrorState extends GoogleSingInState {
  late String signInErrorMessage;
  GoogleSignInErrorState(this.signInErrorMessage);
}

class GoogleSignInLoadingState extends GoogleSingInState {}

class GoogleSignInSuccesslState extends GoogleSingInState {
  late String signInSuccessMessage;
  GoogleSignInSuccesslState(this.signInSuccessMessage);
}
