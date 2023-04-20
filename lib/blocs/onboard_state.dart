part of 'onboard_bloc.dart';

abstract class OnboardState extends Equatable {
  const OnboardState();
}

class OnboardInitial extends OnboardState {
  OnboardInitial(

      );
  @override
  List<Object> get props => [];
}

class SliderState extends OnboardState{
  final int currentSlide;
  @override
  List<Object> get props => [];
  SliderState({required this.currentSlide});

  int get current => this.currentSlide;
}
