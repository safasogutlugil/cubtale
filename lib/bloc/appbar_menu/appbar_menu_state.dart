abstract class AppBarMenuState {}

class AppBarMenuInitialState extends AppBarMenuState {
  final bool isMenuOpen;

  AppBarMenuInitialState({this.isMenuOpen = false});
}

class AppBarMenuOpenState extends AppBarMenuState {}

class AppBarMenuClosedState extends AppBarMenuState {}
