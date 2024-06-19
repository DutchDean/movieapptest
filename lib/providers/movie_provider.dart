// lib/providers/movie_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/movie.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  MovieProvider() {
    loadMovies();
  }

  void addMovie(Movie movie) {
    _movies.add(movie);
    saveMovies();
    notifyListeners();
  }

  void removeMovie(Movie movie) {
    _movies.remove(movie);
    saveMovies();
    notifyListeners();
  }

  void saveMovies() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> movieList = _movies.map((movie) => jsonEncode(movie.toMap())).toList();
    prefs.setStringList('movies', movieList);
  }

  void loadMovies() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? movieList = prefs.getStringList('movies');
    if (movieList != null) {
      _movies = movieList.map((movie) => Movie.fromMap(jsonDecode(movie))).toList();
      notifyListeners();
    }
  }
}
