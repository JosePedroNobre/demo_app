import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_bar_event.dart';
part 'bottom_bar_state.dart';

class BottombarBloc extends Bloc<BottombarEvent, BottombarState> {
  int index;
  BottombarBloc() : super(BottombarUpdatedTab(currentIndex: 0));

  @override
  Stream<BottombarState> mapEventToState(
    BottombarEvent event,
  ) async* {
    if (event is SetBottomBarIndex) {
      try {
        index = event.currentIndex;
        yield BottombarUpdatedTab(currentIndex: event.currentIndex);
      } catch (e) {
        yield BottombarError(e);
      }
    }
  }
}
