import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/bloc/custom_bloc_observer.dart';
import 'package:personal/bloc/movie/movie_bloc.dart';
import 'package:personal/core/app_router.dart';
import 'package:personal/core/app_routes.dart';
import 'package:personal/core/repository.dart';
import 'package:personal/data/core/dio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setBaseUrl();
  setUpDio();
  Bloc.observer = CustomBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repository(),
      lazy: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MoviesBloc>(
            create: (BuildContext context) =>
                MoviesBloc(RepositoryProvider.of<Repository>(context)),
          ),
        ],
        child: MaterialApp(
          title: 'Movie App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: AppRoutes.SPLASH,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
