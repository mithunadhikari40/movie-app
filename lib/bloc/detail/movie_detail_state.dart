part of 'movie_detail_bloc.dart';

enum MovieStatus { initial, loading, loaded, error }

class MovieDetailState extends Equatable {
  final MovieStatus status;
  final String? message;
  final MovieModel? movie;

  const MovieDetailState(
      {this.status = MovieStatus.initial, this.movie, this.message = ''});

  MovieDetailState copyWith(
      {MovieStatus? status, String? message, MovieModel? movie}) {
    return MovieDetailState(
      status: status ?? this.status,
      message: message ?? this.message,
      movie: movie ?? this.movie,
    );
  }

  @override
  String toString() {
    return 'MovieDetailState { status: $status, movie detail: ${movie?.toJson()} }';
  }

  @override
  List<Object?> get props => [status, message, movie];
}
