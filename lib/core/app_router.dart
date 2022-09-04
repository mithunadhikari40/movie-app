import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/bloc/movie/movie_bloc.dart';
import 'package:personal/core/app_routes.dart';
import 'package:personal/data/models/movie_model.dart';
import 'package:personal/ui/screens/home_view.dart';
import 'package:personal/ui/screens/movie_detail_view.dart';

class AppRouter {
  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.SPLASH:
      case AppRoutes.HOME:
        return MaterialPageRoute(builder: (BuildContext context) {
          final bloc = BlocProvider.of<MoviesBloc>(context);
          bloc.add(const FetchMoviesEvent());
          return const HomeView();
        });
      case AppRoutes.DETAIL_PAGE:
        final MovieModel movie = settings.arguments as MovieModel;
        return MaterialPageRoute(builder: (BuildContext context) {
          return MovieDetailView(movie: movie);
        });

      default:
        return MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
            body: Text("No Screen defined for ${settings.name}"),
          );
        });
    }
  }
}
