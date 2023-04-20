import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pawd/enums.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  late int current;
  OnboardBloc(OnboardState initialState) : super(initialState) {
    current = 1;
    on<OnboardEvent>(_handleSlider);
  }

  void _handleSlider(OnboardEvent event, Emitter<OnboardState> emit){
    if(event is SlideEvent){
      print(current);
      if (event.slideEnum == SlideEnum.next) {
        current = (current == 3) ? current : current + 1;
      }
      if (event.slideEnum == SlideEnum.previous) {
        current = (current == 1) ? current : current - 1;
      }
      print(current);
      emit(SliderState(currentSlide: current));
    }
  }
  @override
  List<Object> get props => [];
}
