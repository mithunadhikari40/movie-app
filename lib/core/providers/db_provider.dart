import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal/core/providers/sources.dart';
import 'package:personal/data/core/app_constants.dart';
import 'package:personal/data/models/movie_model.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider implements Sources, Cache {
  static Database? db;

  static final DbProvider instance = DbProvider._internal();

  DbProvider._internal();

  factory DbProvider() {
    _init();
    return instance;
  }

  //
  // DbProvider() {
  //   init();
  // }

  static Future<void> _init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, APP_DB);
    db = await openDatabase(path, version: 1,
        onCreate: (Database database, int version) {
      Batch batch = database.batch();
      batch.execute("""
      CREATE TABLE $TABLE_NAME(
        id INTEGER PRIMARY KEY,
        backdrop_path TEXT,
        title TEXT,
        name TEXT,
        text TEXT,
        original_language TEXT,
        overview TEXT,
        poster_path TEXT,
        release_date TEXT,
        genre_ids BLOB,
        media_type TEXT,
        vote_average REAL,
        popularity REAL,
        vote_count REAL
      )
      """);
      batch.commit();
    });
  }

  @override
  Future<int> insertMovie(MovieModel movieModel) async {
    if (db == null) await _init();
    return db!.insert(TABLE_NAME, movieModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<int> clear() async {
    if (db == null) await _init();
    return db!.delete(TABLE_NAME);
  }

  @override
  Future<List<MovieModel>> fetchAllMovies(int page) async {
    if (db == null) await _init();

    final data = await db!.query(
      TABLE_NAME,
    );

    return data.isNotEmpty
        ? data.map((e) => MovieModel.fromMap(e)).toList()
        : [];
  }

  @override
  Future<MovieModel?> fetchMovieById(int id) async {
    if (db == null) await _init();

    final data = await db!.query(
      TABLE_NAME,
      columns: ['*'],
      where: "id = ?",
      whereArgs: [id],
    );

    return data.isNotEmpty ? MovieModel.fromMap(data.first) : null;
  }
}
