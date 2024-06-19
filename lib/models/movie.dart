// lib/models/movie.dart

class Movie {
  final String title;
  final String director;
  final String? description;
  final int score; // Ensure score is always an int

  Movie({
    required this.title,
    required this.director,
    this.description,
    required this.score,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'director': director,
      'description': description,
      'score': score,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'],
      director: map['director'],
      description: map['description'],
      score: map['score'] ?? 5, // Provide a default score if not present
    );
  }
}
