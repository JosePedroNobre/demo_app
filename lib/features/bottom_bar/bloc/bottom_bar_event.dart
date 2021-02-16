part of 'bottom_bar_bloc.dart';

abstract class BottombarEvent {
  const BottombarEvent();

  @override
  List<Object> get props => [];
}

class SetBottomBarIndex extends BottombarEvent {
  final int currentIndex;

  SetBottomBarIndex(this.currentIndex);
}
