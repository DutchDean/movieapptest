import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movieapptest/providers/movie_provider.dart';
import 'package:movieapptest/models/movie.dart';
import 'package:movieapptest/screens/movie_edit_screen.dart';

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
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieEditScreen(movie: movie),
                ),
              );
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
            Text('Score: ${movie.score}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Text('Release Date: ${movie.releasedate?.year}-${movie.releasedate?.month}-${movie.releasedate?.day}',style: const TextStyle(fontSize: 18),)
            // Add other movie details here
          ],
        ),
      ),
    );
  }
}
