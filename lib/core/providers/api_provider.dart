import 'dart:convert';

import 'package:personal/core/providers/sources.dart';
import 'package:personal/data/core/app_constants.dart';
import 'package:personal/data/core/dio.dart';
import 'package:personal/data/models/movie_model.dart';

class ApiProvider implements Sources {
  @override
  Future<List<MovieModel>> fetchAllMovies(int page) async {
    final uri = "$BASE_URL?page=$page&api_key=$API_KEY";
    try {
      final response = await dio.get(uri);
      final Map? data = response.data;
      if (data == null) return [];
      final List? list = data["results"] as List?;
      if (list == null) return [];
      return list.map((e) => MovieModel.fromMap(e)).toList();
    } catch (e, stack) {
      print(stack);

      return [];
    }
  }

  @override
  Future<MovieModel?> fetchMovieById(int id) async {
    final uri = "$BASE_URL?page=$id&api_key=$API_KEY";
    try {
      final response = await dio.get(uri);
      final Map<String, dynamic>? data =
          jsonDecode(response.data) as Map<String, dynamic>?;
      if (data == null) return null;
      return MovieModel.fromMap(data);
    } catch (e, stack) {
      print(stack);
      return null;
    }
  }
}
