abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpFormErrorState extends SignUpState {
  late String errorMessage;
  SignUpFormErrorState(this.errorMessage);
}

class SignUpFormValidState extends SignUpState {}

class SignUpFormLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  late String signUpSuccessMessage;
  SignUpSuccessState(this.signUpSuccessMessage);
}

class SignUpErrorState extends SignUpState {
  late String signUpErrorMessage;
  SignUpErrorState(this.signUpErrorMessage);
}
