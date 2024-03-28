import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final String apiUrl =
      'https://4t3mnxl8p8.execute-api.us-east-2.amazonaws.com/default/AdminPanelSearch';

  SearchBloc() : super(SearchInitialState()) {
    on<SearchByMailEvent>(_onSearchByMail);
    on<SearchByIdEvent>(_onSearchById);
    on<SearchByDateEvent>(_onSearchByDate);
  }

  Future<void> _onSearchByMail(
      SearchByMailEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': event.email}),
      );
      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['users'] != null && data['users'].isEmpty) {
          emit(SearchEmptyState());
        } else {
          emit(SearchSuccessState(results: data['users']));
        }
      } else {
        emit(SearchErrorState("Error searching by email."));
      }
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }

  Future<void> _onSearchById(
      SearchByIdEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'acc_id': event.id}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Check if 'user' key exists and is not empty
        if (data['users'] != null && data['users'].isNotEmpty) {
          emit(SearchSuccessState(results: data['users']));
        } else {
          emit(SearchEmptyState());
        }
      } else {
        emit(SearchErrorState("Error searching by ID."));
      }
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }

  Future<void> _onSearchByDate(
      SearchByDateEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'acc_creation_date': event.date}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['users'] != null && data['users'].isEmpty) {
          emit(SearchEmptyState());
        } else {
          emit(SearchSuccessState(results: data['users']));
        }
      } else {
        emit(SearchErrorState("Error searching by date."));
      }
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }
}
