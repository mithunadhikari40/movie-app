import 'package:flutter/material.dart';
import 'package:personal/data/core/app_constants.dart';
import 'package:personal/data/models/movie_model.dart';
import 'package:personal/ui/common/widgets/detail/backdrop_rating_widget.dart';
import 'package:personal/ui/common/widgets/detail/title_duration_fab_button.dart';

class MovieDetailView extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailView({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // it will provide us total height and width
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BackdropAndRating(size: size, movie: movie),
            const SizedBox(height: kDefaultPadding / 2),
            TitleDurationAndFabBtn(movie: movie),
            // Genres(movie: movie),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding / 2,
                horizontal: kDefaultPadding,
              ),
              child: Text(
                "Plot Summary",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Text(
                movie.overview!,
                style: const TextStyle(
                  color: Color(0xFF737599),
                ),
              ),
            ),
            // CastAndCrew(casts: movie.cast),
          ],
        ),
      ),
    );
  }
}
