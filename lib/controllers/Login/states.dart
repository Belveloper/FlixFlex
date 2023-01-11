abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class LoginLoadState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class RegisterLoadState extends LoginStates {}

class RegisterSuccessState extends LoginStates {}

class RegisterErrorState extends LoginStates {
  final String error;

  RegisterErrorState(this.error);
}

class ChangePasswordVisibility extends LoginStates {}

class LoginAndRegister extends LoginStates {}

class LogoutLoadState extends LoginStates {}

class LogoutSuccessState extends LoginStates {}

class LogoutErrorState extends LoginStates {
  final String error;

  LogoutErrorState(this.error);
}