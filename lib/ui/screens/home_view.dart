import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/bloc/movie/movie_bloc.dart';
import 'package:personal/ui/common/widgets/error_view.dart';
import 'package:personal/ui/common/widgets/home/movie_list_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies DB"),
      ),
      body: BlocBuilder<MoviesBloc, MovieState>(
        bloc: context.read<MoviesBloc>(),
        builder: (BuildContext context, MovieState state) {
          switch (state.status) {
            case MovieStatus.initial:
            case MovieStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case MovieStatus.error:
              return Center(
                  child: ErrorView(
                message:
                    state.message ?? "Something went wrong, please try again",
                callback: _onRetry,
              ));

            case MovieStatus.loaded:
              return MovieListPage(
                state: state,
              );
          }
        },
      ),
    );
  }

  Future<void> _onRetry() async {
    context.read<MoviesBloc>().add(const RefreshEvent());
  }

  @override
  bool get wantKeepAlive => true;
}
