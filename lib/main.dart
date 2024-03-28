import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubtale/bloc/theme/theme_bloc.dart';
import 'package:cubtale/bloc/theme/theme_state.dart';
import 'package:cubtale/ui/pages/login_page.dart';
import 'package:cubtale/ui/pages/analytics_page.dart';
import 'package:cubtale/bloc/appbar_menu/appbar_menu_bloc.dart';
import 'package:cubtale/bloc/login/login_bloc.dart';
import 'package:cubtale/bloc/login/login_state.dart';
import 'package:cubtale/bloc/search/search_bloc.dart';
import 'package:cubtale/utils/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.initialize();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => AppBarMenuBloc()),
      ],
      child: CubtaleAdminApp(),
    ),
  );
}

class CubtaleAdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'Cubtale Admin Panel',
          theme: themeState.themeData,
          home: BlocListener<LoginBloc, LoginState>(
            listener: (context, loginState) {
              // Redirect to LoginPage if logged out
              if (!loginState.isLoggedIn) {
                Navigator.of(context).pushReplacementNamed('/login');
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, loginState) {
                // If isLoggedIn is true, show AnalyticsPage otherwise, show LoginPage
                return loginState.isLoggedIn ? AnalyticsPage() : LoginPage();
              },
            ),
          ),
          routes: {
            '/login': (context) => LoginPage(),
            '/analytics': (context) => AnalyticsPage(),
          },
        );
      },
    );
  }
}
