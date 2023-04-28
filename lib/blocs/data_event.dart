
part of 'data_bloc.dart';

@immutable
abstract class DataEvent extends Equatable{}

class AddUser extends DataEvent{
  final User userData;
  AddUser({required this.userData});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddTask extends DataEvent{
  final Map<String, String> task;
  final String email;
  AddTask({required this.email, required this.task});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OpenTaskWindow extends DataEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchData extends DataEvent{
  final String email;
  FetchData({required this.email});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class UpdateUser extends DataEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateTask extends DataEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeleteTask extends DataEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


