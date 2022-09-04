import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/core/repository.dart';
import 'package:personal/data/models/movie_model.dart';
import 'package:stream_transform/stream_transform.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MoviesBloc extends Bloc<MovieEvent, MovieState> {
  final throttleDuration = const Duration(milliseconds: 100);

  EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }

  final Repository _repository;

  MoviesBloc(this._repository) : super(const MovieState()) {
    on<MovieEvent>(
      _onMoviesFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onMoviesFetched(
      MovieEvent event, Emitter<MovieState> emit) async {
    if (event is FetchMoviesEvent) {
      if (state.hasReachedMax) return;
      emit(state.copyWith(status: MovieStatus.loading));

      try {
        final movies = await _repository.fetchMovies(state.page + 1);
        final List<MovieModel> existingMovies = List.from(state.movies ?? []);

        emit(state.copyWith(
            status: MovieStatus.loaded,
            movies: existingMovies..addAll(movies),
            hasReachedMax: movies.isEmpty));
      } on Exception {
        emit(state.copyWith(
            status: MovieStatus.error, message: "something went wrong"));
      }
    } else if (event is RefreshEvent) {
      await _repository.clearData();
      emit(state.copyWith(status: MovieStatus.initial));
      try {
        final ids = await _repository.fetchMovies(state.page + 1);
        emit(state.copyWith(status: MovieStatus.loaded, movies: ids));
      } on Exception {
        emit(state.copyWith(
            status: MovieStatus.error, message: "something went wrong"));
      }
    }
  }
}
