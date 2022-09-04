import 'package:personal/data/models/movie_model.dart';

abstract class Sources {
  Future<List<MovieModel>> fetchAllMovies(int page);
  Future<MovieModel?> fetchMovieById(int id);
}

abstract class Cache {
  Future<int> clear();
  Future<int> insertMovie(MovieModel movie);
}
