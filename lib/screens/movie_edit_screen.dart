import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:movieapptest/providers/movie_provider.dart';
import 'package:movieapptest/models/movie.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MovieEditScreen extends StatefulWidget {
  final Movie movie;

  const MovieEditScreen({super.key, required this.movie});

  @override
  _MovieEditScreenState createState() => _MovieEditScreenState();
}

class _MovieEditScreenState extends State<MovieEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _directorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
  DateTime? _selectedDate;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.movie.title;
    _directorController.text = widget.movie.director;
    _descriptionController.text = widget.movie.description ?? '';
    _scoreController.text = widget.movie.score.toString();
    _selectedDate = widget.movie.releaseDate;
    _imageFile = widget.movie.imagePath != null ? File(widget.movie.imagePath!) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Release Date',
                      errorText: _selectedDate == null ? 'Please enter a release date' : null,
                    ),
                    child: Text(
                      _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : 'Select Date',
                    ),
                  ),
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
                if (_imageFile != null)
                  Image.file(
                    _imageFile!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                TextButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text('Pick Image'),
                  onPressed: () async {
                    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        _imageFile = File(pickedFile.path);
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      try {
                        final updatedMovie = Movie(
                          id: widget.movie.id,
                          title: _titleController.text,
                          director: _directorController.text,
                          description: _descriptionController.text.isNotEmpty ? _descriptionController.text : null,
                          releaseDate: _selectedDate,
                          score: int.parse(_scoreController.text),
                          imagePath: _imageFile?.path,
                        );
                        Provider.of<MovieProvider>(context, listen: false).updateMovie(updatedMovie);
                        Navigator.pop(context);
                      } catch (error) {
                        // Handle error
                      }
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }
}
