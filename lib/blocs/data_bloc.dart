import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:pawd/utils/data_repository.dart';

part 'data_event.dart';

part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  late final DatabaseRepository _dataRepo;
  Map<String, dynamic>? userData;

  DataBloc() : super(DataInitial()) {
    _dataRepo = DatabaseRepository(db: FirebaseFirestore.instance);

    on<FetchData>(_fetchData);
    on<AddTask>(_addTask);
    on<OpenTaskWindow>(_handleTaskWindow);
  }

  void _fetchData(FetchData event, Emitter<DataState> state) async {
    emit(DataLoading());
    try {
      final user = await _dataRepo.getUser(event.email);
      if (user.exists) {
        userData = user.data()!;
        print(userData);
        final taskMap = userData!["tasks"];


        emit(DataLoaded());
      } else {
        emit(DataFailure(message: "User does not exist"));
      }
    } catch (e) {
      emit(DataFailure(message: e.toString()));
    }
  }

  void _addTask(AddTask event, Emitter<DataState> state) async {

    emit(TaskLoading());
    try {
      await _dataRepo.addTask(event.email, event.task);
      //TODO : Fetch Updated Task List
      emit(CloseNewTask());
      emit(DataLoaded());
    } catch (e) {
      emit(DataFailure(message: e.toString()));
    }
  }

  FutureOr<void> _handleTaskWindow(
      OpenTaskWindow event, Emitter<DataState> emit) {
    emit(OpenNewTask());
  }
}
