abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchEmptyState extends SearchState {}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState(this.message);
}

class SearchSuccessState extends SearchState {
  final List<dynamic> results;

  SearchSuccessState({required this.results});
}
