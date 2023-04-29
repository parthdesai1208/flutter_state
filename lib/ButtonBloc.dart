import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:button_state/ButtonEvent.dart';
import 'package:button_state/ButtonState.dart';

class ButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  ButtonBloc() : super(ButtonUIState(isShowingProgress: false)) {
    on<ButtonClickEvent>((event, emit) async {
      emit(ButtonUIState(isShowingProgress: true));
      await Future.delayed(const Duration(seconds: 5));
      emit(ButtonUIState(isShowingProgress: false));
    });
  }

/* @override
  ButtonState get initialState => ButtonUIState(isShowingProgress: false);

  @override
  Stream<ButtonState> mapEventToState(ButtonState event) async*{
      if(event is ButtonClickEvent){
        */ /*bool b = (state as ButtonUIState).isShowingProgress;
        b = true;*/ /*
        ButtonUIState(isShowingProgress: true);

        await Future.delayed(const Duration(seconds: 5));

        ButtonUIState(isShowingProgress: false);
      }
  }*/
}
