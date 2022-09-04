part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {
  const MovieEvent();
}

class FetchMoviesEvent extends MovieEvent {
  const FetchMoviesEvent();
}

class RefreshEvent extends MovieEvent {
  const RefreshEvent();
}

class GetDetailEvent extends MovieEvent {
  final int id;

  const GetDetailEvent(this.id);
}
