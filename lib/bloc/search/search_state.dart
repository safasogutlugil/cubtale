abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchByMailState extends SearchState {
  final String result;

  SearchByMailState({required this.result});
}

class SearchByIdState extends SearchState {
  final String result;

  SearchByIdState({required this.result});
}

class SearchByDateState extends SearchState {
  final String result;

  SearchByDateState({required this.result});
}
