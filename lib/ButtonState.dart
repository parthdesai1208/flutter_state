

abstract class ButtonState {}

class ButtonUIState extends ButtonState{
  final bool isShowingProgress;
  ButtonUIState({required this.isShowingProgress});
}

