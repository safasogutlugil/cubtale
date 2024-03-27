// appbar_menu_state.dart
abstract class AppBarMenuState {}

class AppBarMenuInitialState extends AppBarMenuState {
  final bool isMenuOpen;

  AppBarMenuInitialState({this.isMenuOpen = false});
}

// Optionally define specific open and closed states if needed
class AppBarMenuOpenState extends AppBarMenuState {}

class AppBarMenuClosedState extends AppBarMenuState {}
