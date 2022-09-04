import 'package:flutter/material.dart';

const BASE_URL = "https://api.themoviedb.org/3/trending/all/week";
const APP_DB = "movie_db";
const TABLE_NAME = "table_movies";
const API_KEY = "fa0c92af3ea4daf346aace070bc25bf8";

// Colos that use in our app
const kSecondaryColor = Color(0xFFFE6D8E);
const kTextColor = Color(0xFF12153D);
const kTextLightColor = Color(0xFF9A9BB2);
const kFillStarColor = Color(0xFFFCC419);

const kDefaultPadding = 20.0;

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 4),
  blurRadius: 4,
  color: Colors.black26,
);
