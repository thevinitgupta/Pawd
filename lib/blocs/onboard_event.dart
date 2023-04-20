part of 'onboard_bloc.dart';

abstract class OnboardEvent extends Equatable {
  const OnboardEvent();
}

class SlideEvent extends OnboardEvent{
  final SlideEnum slideEnum;
  SlideEvent({
    required this.slideEnum
  });
  @override
  List<Object> get props => [];
}
