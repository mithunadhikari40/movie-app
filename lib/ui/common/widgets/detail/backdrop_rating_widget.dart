import 'package:flutter/material.dart';
import 'package:personal/data/core/app_constants.dart';
import 'package:personal/data/models/movie_model.dart';

class BackdropAndRating extends StatelessWidget {
  const BackdropAndRating({
    Key? key,
    required this.size,
    required this.movie,
  }) : super(key: key);

  final Size size;
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 40% of our total height
      height: size.height * 0.4,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.4 - 50,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(50)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(movie.getImagePath),
              ),
            ),
          ),
          // Rating Box
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              // it will cover 90% of our total width
              width: size.width * 0.9,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 50,
                    color: const Color(0xFF12153D).withOpacity(0.2),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // SvgPicture.asset("assets/icons/star_fill.svg"),
                        const SizedBox(height: kDefaultPadding / 4),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "${movie.vote_average}/",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const TextSpan(text: "10\n"),
                              const TextSpan(
                                text: "150,212",
                                style: TextStyle(color: kTextLightColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Rate this
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // SvgPicture.asset("assets/icons/star.svg"),
                        const SizedBox(height: kDefaultPadding / 4),
                        Text("Rate This",
                            style: Theme.of(context).textTheme.bodyText2),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF51CF66),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            "${movie.vote_count}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding / 4),
                        const Text(
                          "Metascore",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const Text(
                          "62 critic reviews",
                          style: TextStyle(color: kTextLightColor),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          // Back Button
          const SafeArea(child: BackButton()),
        ],
      ),
    );
  }
}
