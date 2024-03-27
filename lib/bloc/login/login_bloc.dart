import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:cubtale/utils/user_preferences.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<ResetErrorEvent>(_onResetError);
    
  }
  void _onUsernameChanged(
      LoginUsernameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }
void _onResetError(
      ResetErrorEvent event, Emitter<LoginState> emit) {
    // Reset the error message in the state
    emit(state.copyWith(errorMessage: ''));
  }
  

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await http.post(
        Uri.parse(
            'https://p7y0pin0cl.execute-api.us-east-2.amazonaws.com/default/AdminPanelLogin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'username': state.username, 'password': state.password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('error_msg')) {
          _handleError(emit);
        } else {
          // Store credentials and expiry date
          final expiryDate =
              DateTime.now().add(Duration(days: 14)); // Two weeks from now
          await UserPreferences.setCredentials(data['acc_token'], expiryDate);
          emit(state.copyWith(
              isLoading: false, errorMessage: null, isLoggedIn: true));
        }
      } else {
        _handleError(emit);
      }
    } catch (e) {
      _handleError(emit);
    }
  }

  void _handleError(Emitter<LoginState> emit) {
    emit(state.copyWith(errorMessage: "Oops! Something went wrong!"));
  }
}
