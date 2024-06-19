// lib/screens/movie_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../providers/movie_provider.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Provider.of<MovieProvider>(context, listen: false).removeMovie(movie);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Director: ${movie.director}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            if (movie.description != null) Text(movie.description!),
            const SizedBox(height: 10),
            Text('Score: ${movie.score}', style: const TextStyle(fontSize: 18)), // Display score
            // Add other movie details here
          ],
        ),
      ),
    );
  }
}
