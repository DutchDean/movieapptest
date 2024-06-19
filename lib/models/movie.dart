class Movie {
  final String title;
  final String director;
  final String? description;
  final DateTime? releasedate;
  final int score;

  Movie({
    required this.title,
    required this.director,
    this.description,
    required this.releasedate,
    required this.score, required id, DateTime? releaseDate,
  });

  get id => null;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'director': director,
      'description': description,
      'release date': releasedate?.toIso8601String(),
      'score': score,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'],
      director: map['director'],
      description: map['description'],
      releasedate: map['release date'] != null ? DateTime.parse(map['release date']) : null,
      score: map['score'] ?? 5, id: null,
    );
  }
}
