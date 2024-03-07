part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

abstract class AuthenticationActionState extends AuthenticationState{}

class AuthenticationInitialState extends AuthenticationState {}

class RegIniti extends AuthenticationActionState{}

class RegisterSuccessfulState extends AuthenticationActionState{}

class LoginUserPageUiState extends AuthenticationState{}

class LoginUserUsingRegisteredEmail extends AuthenticationState{}

class RegistrationFailedSatte extends AuthenticationState{
  String? errorMessage;
  RegistrationFailedSatte({required this.errorMessage});

}


class LoginUserInitialState extends AuthenticationActionState{}



class LoginFailedState extends AuthenticationActionState{
  String? errorMessage;
  LoginFailedState({required this.errorMessage});

}

class LoginSuccessState extends AuthenticationActionState{}

class AuthenticationCheckState extends AuthenticationActionState{
  final User? user;

  AuthenticationCheckState({required this.user});


}


class UserCreateLoading extends AuthenticationState{}