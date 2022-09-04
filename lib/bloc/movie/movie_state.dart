part of 'movie_bloc.dart';

enum MovieStatus { initial, loading, loaded, error }

class MovieState extends Equatable {
  final MovieStatus status;
  final String? message;
  final List<MovieModel>? movies;
  final bool hasReachedMax;
  final int page;

  const MovieState(
      {this.status = MovieStatus.initial,
      this.movies = const [],
      this.hasReachedMax = false,
      this.page = 0,
      this.message = ''});

  MovieState copyWith(
      {MovieStatus? status,
      String? message,
      List<MovieModel>? movies,
      int? page,
      bool? hasReachedMax}) {
    return MovieState(
      status: status ?? this.status,
      message: message ?? this.message,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  String toString() {
    return '''MovieState { status: $status, movies: ${movies?.length} }''';
  }

  @override
  List<Object?> get props => [status, message, movies, page];
}
