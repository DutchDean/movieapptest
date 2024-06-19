import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movieapptest/providers/movie_provider.dart';
import 'package:movieapptest/models/movie.dart';
import 'package:movieapptest/screens/movie_edit_screen.dart';
import 'dart:io';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (movie.imagePath != null && movie.imagePath!.isNotEmpty)
                Center(
                  child: Image.file(
                    File(movie.imagePath!),
                    fit: BoxFit.contain,
                    height: 300,
                    width: double.infinity,
                  ),
                ),
              const SizedBox(height: 20),
              if (movie.memeImage != null && movie.memeImage!.isNotEmpty)
                Center(
                  child: Image.file(
                    File(movie.memeImage!),
                    fit: BoxFit.contain,
                    height: 300,
                    width: double.infinity,
                  ),
                ),
              const SizedBox(height: 20),
              Text('Director: ${movie.director}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              if (movie.description != null) Text(movie.description!),
              const SizedBox(height: 10),
              Text('Score: ${movie.score}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              Text('Release Date: ${movie.releaseDate?.year}-${movie.releaseDate?.month}-${movie.releaseDate?.day}', style: const TextStyle(fontSize: 18)),
              // Add other movie details here
            ],
          ),
        ),
      ),
    );
  }
}
