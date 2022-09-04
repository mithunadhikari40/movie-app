part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent {
  const MovieDetailEvent();
}

class FetchMoviesDetailEvent extends MovieDetailEvent {
  final int id;
  const FetchMoviesDetailEvent(this.id);
}

class RefreshDetailEvent extends MovieDetailEvent {
  const RefreshDetailEvent();
}
