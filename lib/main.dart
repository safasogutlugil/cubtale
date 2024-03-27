import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubtale/utils/user_preferences.dart';
import 'package:cubtale/bloc/theme/theme_bloc.dart';
import 'package:cubtale/bloc/theme/theme_state.dart';
import 'package:cubtale/ui/pages/login_page.dart';
import 'package:cubtale/ui/pages/analytics_page.dart'; // You need to create this

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.initialize();
  runApp(CubtaleAdminApp());
}

class CubtaleAdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Cubtale Admin Panel',
            theme: themeState.themeData,
            initialRoute: '/',
            routes: {
              '/': (context) => LoginPage(),
              '/analytics': (context) =>
                  AnalyticsPage(), // You need to define this widget
            },
          );
        },
      ),
    );
  }
}
