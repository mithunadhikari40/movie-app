import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/core/repository.dart';
import 'package:personal/data/models/movie_model.dart';
import 'package:stream_transform/stream_transform.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MoviesDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final throttleDuration = const Duration(milliseconds: 100);

  EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }

  final Repository _repository;

  MoviesDetailBloc(this._repository) : super(const MovieDetailState()) {
    on<MovieDetailEvent>(
      _onMoviesDetailFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onMoviesDetailFetched(
      MovieDetailEvent event, Emitter<MovieDetailState> emit) async {
    if (event is FetchMoviesDetailEvent) {
      final id = event.id;

      /// do something

    } else if (event is RefreshDetailEvent) {
      /// do something
    }
  }
}
