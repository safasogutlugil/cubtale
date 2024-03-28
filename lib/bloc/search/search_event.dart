abstract class SearchEvent {}

class SearchByMailEvent extends SearchEvent {
  final String email;

  SearchByMailEvent({required this.email});
}

class SearchByIdEvent extends SearchEvent {
  final String id;

  SearchByIdEvent({required this.id});
}

class SearchByDateEvent extends SearchEvent {
  final String date;

  SearchByDateEvent({required this.date});
}