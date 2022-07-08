abstract class LoginEvent {}

class LoginTextChangeEvent extends LoginEvent {
  late String loginEmailValue;
  late String loginPasswordValue;
  LoginTextChangeEvent(this.loginEmailValue, this.loginPasswordValue);
}

class LoginSubmitEvent extends LoginEvent {
  late String loginEmail;
  late String loginPassword;
  LoginSubmitEvent(this.loginEmail, this.loginPassword);
}

// class LoginTextChangeEvent extends LoginEvent {}

// class LoginTextChangeEvent extends LoginEvent {}
