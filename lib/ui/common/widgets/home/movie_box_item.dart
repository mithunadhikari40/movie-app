import 'package:flutter/material.dart';
import 'package:personal/core/app_routes.dart';
import 'package:personal/data/models/movie_model.dart';
import 'package:personal/ui/common/widgets/home/movie_item_front_banner.dart';

class MovieBoxItem extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback onItemClick;

  const MovieBoxItem({Key? key, required this.movie, required this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemClick,
      child: Stack(
        children: [
          Image.network(
            movie.getImagePath,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: MovieItemFrontBanner(text: movie.getTitle),
          ),
        ],
      ),
    );
  }
}
