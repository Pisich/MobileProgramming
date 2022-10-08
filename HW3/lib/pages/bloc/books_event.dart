part of 'books_bloc.dart';

class BooksEvent extends Equatable {
  const BooksEvent();

  @override
  List<Object> get props => [];
}

class BooksResultsReadyEvent extends BooksEvent {}

class BooksSearchEvent extends BooksEvent {
  final String query;

  BooksSearchEvent(this.query);
}
