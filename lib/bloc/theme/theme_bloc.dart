import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
          ThemeState(
            themeData: ThemeData.light().copyWith(
              primaryColor: Color.fromRGBO(28, 150, 138, 0.494),
              scaffoldBackgroundColor:
                  Colors.white, 
              appBarTheme: AppBarTheme(
                color: Color.fromRGBO(28, 150, 138, 0.494),
              ),
              cardTheme: CardTheme(
                color: Color.fromRGBO(28, 150, 138, 0.494),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), 
                ),
              ),
              textTheme: ThemeData.light()
                  .textTheme
                  .apply(
                    bodyColor: Color.fromRGBO(
                        28, 150, 138, 0.494), 
                    displayColor: Color.fromRGBO(
                        28, 150, 138, 0.494), 
                  )
                  .copyWith(
                    titleMedium: ThemeData.light()
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(28, 150, 138, 0.494)),
                  borderRadius: BorderRadius.circular(
                      20.0), 
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(28, 150, 138, 0.494),
                ),
              ),
            ),
          ),
        ) {
    on<ThemeToggle>(_onThemeToggle);
    _loadTheme();
  }

  FutureOr<void> _onThemeToggle(
      ThemeToggle event, Emitter<ThemeState> emit) async {
    final isDarkMode = state.isDarkMode;
    final ThemeData newTheme = isDarkMode
        ? ThemeData.light().copyWith(
            primaryColor: Color.fromRGBO(28, 150, 138, 0.494),
            scaffoldBackgroundColor:
                Colors.white, 
            appBarTheme: AppBarTheme(
              color: Color.fromRGBO(28, 150, 138, 0.494),
            ),
            cardTheme: CardTheme(
              color: Color.fromRGBO(28, 150, 138, 0.494),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), 
              ),
            ),
            textTheme: ThemeData.light()
                .textTheme
                .apply(
                  bodyColor: Color.fromRGBO(
                      28, 150, 138, 0.494), 
                  displayColor: Color.fromRGBO(
                      28, 150, 138, 0.494), 
                )
                .copyWith(
                  titleMedium: ThemeData.light()
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(28, 150, 138, 0.494)),
                borderRadius:
                    BorderRadius.circular(20.0), 
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(28, 150, 138, 0.494),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          )
        : ThemeData.dark().copyWith(
            primaryColor: Color.fromRGBO(28, 150, 138, 0.494), 
            scaffoldBackgroundColor:
                Colors.grey[850], 
            textTheme: ThemeData.dark().textTheme.apply(
                  bodyColor: Colors.white,
                ),
            inputDecorationTheme: ThemeData.dark()
                .inputDecorationTheme
                .copyWith(
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(28, 150, 138, 0.494)),
                  ),
                ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Color.fromRGBO(28, 150, 138,
                    0.494), 
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
            ),
          );
    emit(ThemeState(themeData: newTheme));
    // Persist the theme preference
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', !isDarkMode);
  }

  Future<void> _loadTheme() async {
    var prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    if (isDarkMode) {
      add(ThemeToggle()); 
    }
  }
}
