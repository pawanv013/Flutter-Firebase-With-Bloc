abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginFormErrorState extends LoginState {
  late String loginFormErrorMessage;
  LoginFormErrorState(this.loginFormErrorMessage);
}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  late String loginSuccessMessage;
  LoginSuccessState(this.loginSuccessMessage);
}

class LoginFormValidState extends LoginState {}

class LoginErrorState extends LoginState {
  late String loginErrorMessage;
  LoginErrorState(this.loginErrorMessage);
}
