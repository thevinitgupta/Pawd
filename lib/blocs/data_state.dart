part of 'data_bloc.dart';

@immutable
abstract class DataState extends Equatable{}

class DataInitial extends DataState {
  @override
  List<Object?> get props => [];
}

//TODO : Add States -> DataLoading, DataLoaded, DataUpdated, DataDeleted


class DataLoading extends DataState {
  @override
  List<Object?> get props => [];
}
class DataLoaded extends DataState {
  @override
  List<Object?> get props => [];
}

class OpenNewTask extends DataState{
  List<Object?> get props => [];
}

class CloseNewTask extends DataState{
  List<Object?> get props => [];
}

class TaskLoading extends DataState{
  List<Object?> get props => [];
}

class DataUpdated extends DataState {
  @override
  List<Object?> get props => [];
}
class DataDeleted extends DataState {
  @override
  List<Object?> get props => [];
}

class DataFailure extends DataState{
  final String message;
  DataFailure({required this.message});
  @override
  List<Object?> get props => [];
}

