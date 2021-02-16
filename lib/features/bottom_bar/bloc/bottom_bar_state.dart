part of 'bottom_bar_bloc.dart';

abstract class BottombarState {
  const BottombarState();

  @override
  List<Object> get props => [];
}

class BottombarUpdatedTab extends BottombarState {
  final int currentIndex;

  BottombarUpdatedTab({this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}

class BottombarError extends BottombarState {
  final String message;

  BottombarError(this.message);

  @override
  List<Object> get props => [message];
}
