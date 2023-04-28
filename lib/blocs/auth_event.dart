part of 'auth_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  List<Object> get props => [];
}

class AuthInitial extends AuthenticationEvent {}

class AuthenticationStarted extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationStarted(this.email, this.password);
}

class SendLoginRequest extends AuthenticationEvent {
  final String email;
  final String password;

  SendLoginRequest(this.email, this.password);
}

class AuthenticationSignedIn extends AuthenticationEvent {}

class AuthenticationSignedOut extends AuthenticationEvent {}
