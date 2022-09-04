
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@immutable
@JsonSerializable()
class MovieModel extends Equatable {
 // final bool? adult;
//  final bool? video;
  final String? backdrop_path;
  final int? id;
  final String? title;
  final String? name;
  final String? original_language;
  final String? overview;
  final String? poster_path;
  final String? media_type;
//  final List<int>? genre_ids;
  final num? vote_average;
  final num? popularity;
  final num? vote_count;
  final String? release_date;

  const MovieModel({
   // this.adult,
  //  this.video,
    this.backdrop_path,
    this.id,
    this.title,
    this.name,
    this.original_language,
    this.overview,
    this.poster_path,
    this.media_type,
  //  this.genre_ids,
    this.vote_average,
    this.popularity,
    this.vote_count,
    this.release_date,
  });

  MovieModel copy({
  //  bool? adult,
  //  bool? video,
    String? backdrop_path,
    int? id,
    String? title,
    String? name,
    String? original_language,
    String? overview,
    String? poster_path,
    String? media_type,
 //   List<int>? genre_ids,
    num? vote_average,
    num? popularity,
    num? vote_count,
    String? release_date,
  }) {
    return MovieModel(
    //  adult: adult ?? this.adult,
    //  video: video ?? this.video,
      backdrop_path: backdrop_path ?? this.backdrop_path,
      id: id ?? this.id,
      title: title ?? this.title,
      name: name ?? this.name,
      original_language: original_language ?? this.original_language,
      overview: overview ?? this.overview,
      poster_path: poster_path ?? this.poster_path,
      media_type: media_type ?? this.media_type,
   //   genre_ids: genre_ids ?? this.genre_ids,
      vote_average: vote_average ?? this.vote_average,
      popularity: popularity ?? this.popularity,
      vote_count: vote_count ?? this.vote_count,
      release_date: release_date ?? this.release_date,
    );
  }

  static MovieModel fromMap(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  static Map<String, dynamic> toMap(MovieModel obj) => _$MovieModelToJson(obj);

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
  @JsonKey(ignore: true)
  String get getTitle => title ?? name ?? "" ;
  @JsonKey(ignore: true)
  String get getImagePath =>  'https://image.tmdb.org/t/p/w200$poster_path';
  @override
  @JsonKey(ignore: true)
  List<Object?> get props => [
     //   adult,
      //  video,
        backdrop_path,
        id,
        title,
        name,
        original_language,
        overview,
        poster_path,
        media_type,
      //  genre_ids,
        vote_average,
        popularity,
        vote_count,
        release_date,
      ];
}
