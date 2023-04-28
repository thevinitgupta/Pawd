import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:pawd/utils/data_repository.dart';
import 'package:pawd/utils/shared_pref_helper.dart';

import '../models/user.dart';
import '../utils/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  final DatabaseRepository _dataRepo = DatabaseRepository();
  User? user;

  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthenticationInitial()) {
    on<AuthInitial>(_initialize);
    on<AuthenticationStarted>(_handleAuthentication);
    on<SendLoginRequest>(_handleLogin);
    on<AuthenticationSignedOut>(_handleLogout);
  }

  void _handleAuthentication(
      AuthenticationStarted event, Emitter<AuthenticationState> emit) async {
    try {
      emit(AuthenticationLoading());
      //
      // await _userRepository.signOut();
      final userCredential =
          await _userRepository.signUp(event.email, event.password);

      if (userCredential.user != null) {
        user = userCredential.user;
        await _dataRepo.createDoc(user!);
        SharedPrefHelper.setLoggedIn(true);
        emit(AuthenticationSuccess(userCredential.user!));
      } else {
        emit(AuthenticationFailure("Unable to create user"));
      }
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }

  void _handleLogin(
      SendLoginRequest event, Emitter<AuthenticationState> emit) async {
    try {
      emit(AuthenticationLoading());
      //
      // await _userRepository.signOut();
      final userCredential = await _userRepository.signInWithCredentials(
          event.email, event.password);

      if (userCredential.user != null) {
        user = userCredential.user;
        SharedPrefHelper.setLoggedIn(true);
        emit(AuthenticationSuccess(userCredential.user!));
      } else {
        emit(AuthenticationFailure("Unable to login"));
      }
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }

  void _handleLogout(
      AuthenticationSignedOut event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      await _userRepository.signOut();
      SharedPrefHelper.setLoggedIn(false);
      emit(UnAuthenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationFailure(e.message!));
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }

  FutureOr<void> _initialize(
      AuthInitial event, Emitter<AuthenticationState> emit) async {
    try {
      emit(AuthenticationLoading());
      user = await _userRepository.getUser();
      if (user != null) {
        emit(AuthenticationSuccess(user!));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(UnAuthenticated());
    }
  }
}
