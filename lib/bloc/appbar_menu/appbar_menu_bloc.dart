import 'package:flutter_bloc/flutter_bloc.dart';

import 'appbar_menu_event.dart';
import 'appbar_menu_state.dart';

class AppBarMenuBloc extends Bloc<AppBarMenuEvent, AppBarMenuState> {
  AppBarMenuBloc() : super(AppBarMenuInitialState(isMenuOpen: false)) {
    on<AppBarMenuToggleEvent>((event, emit) {
      final currentState = state;
      if (currentState is AppBarMenuInitialState) {
        // Toggle the isMenuOpen flag based on its current state
        emit(AppBarMenuInitialState(isMenuOpen: !currentState.isMenuOpen));
      }
    });
  }
}
