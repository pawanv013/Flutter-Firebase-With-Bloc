abstract class SignUpEvent {}

class SignUpTextValueChangeEvent extends SignUpEvent {
  late final String emailValue;
  late final String passwordValue;
  late final String conformPasswordValue;
  SignUpTextValueChangeEvent(
      this.emailValue, this.passwordValue, this.conformPasswordValue);
}

class SignUpSubmitEvent extends SignUpEvent {
  late final String email;
  late final String password;
  late final String conformPassword;
  SignUpSubmitEvent(this.email, this.password, this.conformPassword);
}
