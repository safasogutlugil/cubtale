import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<SearchByMailEvent>((event, emit) {
      // Call the API and emit SearchByMailState
      emit(SearchByMailState(result: "Result for ${event.email}"));
    });
    on<SearchByIdEvent>((event, emit) {
      // Call the API and emit SearchByIdState
      emit(SearchByIdState(result: "Result for ID ${event.id}"));
    });
    on<SearchByDateEvent>((event, emit) {
      // Call the API and emit SearchByDateState
      emit(SearchByDateState(result: "Result for Date ${event.date}"));
    });
  }
}
