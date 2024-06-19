// lib/screens/movie_add_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../models/movie.dart';

class MovieAddScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _directorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();

  MovieAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _directorController,
                decoration: const InputDecoration(labelText: 'Director'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a director';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 4,
              ),
              TextFormField(
                controller: _scoreController,
                decoration: const InputDecoration(labelText: 'Score (1-10)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a score';
                  }
                  final score = int.tryParse(value);
                  if (score == null || score < 1 || score > 10) {
                    return 'Please enter a score between 1 and 10';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final movie = Movie(
                      title: _titleController.text,
                      director: _directorController.text,
                      description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
                      score: int.parse(_scoreController.text), // Ensure score is provided
                    );
                    Provider.of<MovieProvider>(context, listen: false).addMovie(movie);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Movie'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
