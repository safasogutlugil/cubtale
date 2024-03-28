import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubtale/utils/user_preferences.dart';
import 'package:cubtale/bloc/theme/theme_bloc.dart';
import 'package:cubtale/bloc/theme/theme_state.dart';
import 'package:cubtale/ui/pages/login_page.dart';
import 'package:cubtale/ui/pages/analytics_page.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/login/login_state.dart'; // You need to create this

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.initialize();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        // Add other global Blocs here
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
            listener: (context, state) {
              if (!state.isLoggedIn) {
                // When not logged in, navigate to the LoginPage
                Navigator.of(context).pushReplacementNamed('/login');
              } else {
                // When logged in, navigate to the AnalyticsPage
                Navigator.of(context).pushReplacementNamed('/analytics');
              }
            },
            child: LoginPage(), // Your initial page
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
