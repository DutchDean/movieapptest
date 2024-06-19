import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movieapptest/providers/movie_provider.dart';
import 'package:movieapptest/screens/movie_detail_screen.dart';
import 'package:movieapptest/screens/movie_add_screen.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          return ListView.builder(
            itemCount: movieProvider.movies.length,
            itemBuilder: (context, index) {
              final movie = movieProvider.movies[index];
              return Dismissible(
                key: Key(movie.title),
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  movieProvider.removeMovie(movie);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${movie.title} removed')),
                  );
                },
                child: ListTile(
                  title: Text(movie.title),
                  subtitle: Text('${movie.director} - Score: ${movie.score}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movie: movie),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MovieAddScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
