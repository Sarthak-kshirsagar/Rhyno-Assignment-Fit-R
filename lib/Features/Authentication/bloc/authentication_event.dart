part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationInitialEvent extends AuthenticationEvent{}
//to check wheather the user is logged in or not
class AuthenticationCheck extends AuthenticationEvent{}


//for non authentication users
class NonAuthenticateUserUi extends AuthenticationEvent{}

class AuthenticateUserUi extends AuthenticationEvent{}


class RegisterationInitialEvent extends AuthenticationEvent{}

class RegisterUserEvent extends AuthenticationEvent{
  final String emailAddress;
  final String password;
  RegisterUserEvent({required this.emailAddress,required this.password});
}

class LoginAuthenticatedUserEvent extends AuthenticationEvent{
  final String emailAddress;
  final String password;
  LoginAuthenticatedUserEvent({required this.emailAddress,required this.password});
}

class Logout extends AuthenticationEvent{}



