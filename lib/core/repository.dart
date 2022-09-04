import 'package:personal/core/providers/api_provider.dart';
import 'package:personal/core/providers/db_provider.dart';
import 'package:personal/core/providers/sources.dart';
import 'package:personal/data/models/movie_model.dart';

class Repository {
  List<Sources> sources = [DbProvider.instance, ApiProvider()];
  List<Cache> caches = [DbProvider.instance];

  Future<List<MovieModel>> fetchMovies(int page) async {
    Sources? source;
    List<MovieModel> movies = [];
    for (source in sources) {
      movies = await source.fetchAllMovies(page);
      if (movies.isNotEmpty) {
        break;
      }
    }

    for (final origin in caches) {
      if (source != origin as Sources) {
        for (final item in movies) {
          origin.insertMovie(item);
        }
      }
    }
    return movies;
  }

  Future<MovieModel?> fetchMovie(int id) async {
    Sources? source;
    MovieModel? item;
    for (source in sources) {
      item = await source.fetchMovieById(id);
      if (item != null) {
        break;
      }
    }

    for (var origin in caches) {
      if (source != origin as Sources && item != null) {
        origin.insertMovie(item);
      }
    }
    return item;
  }

  Future<void> clearData() async {
    for (var c in caches) {
      c.clear();
    }
  }
}
