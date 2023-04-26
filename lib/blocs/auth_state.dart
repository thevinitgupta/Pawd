part of 'auth_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState();

  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
class UnAuthenticated extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final User firebaseUser;

  AuthenticationSuccess(this.firebaseUser);

  List<Object> get props => [firebaseUser];
}

class AuthenticationFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationFailure(this.errorMessage);
}
