class Movie {
  final String id;
  final String title;
  final String director;
  final String? description;
  final DateTime? releaseDate;
  final int score;
  final String? imagePath;
  final String? memeImage;  // Add this line

  Movie({
    required this.id,
    required this.title,
    required this.director,
    this.description,
    required this.releaseDate,
    required this.score,
    this.imagePath,
    this.memeImage,  // Add this line
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'director': director,
      'description': description,
      'releaseDate': releaseDate?.toIso8601String(),
      'score': score,
      'imagePath': imagePath,
      'memeImage': memeImage,  // Add this line
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      director: map['director'] ?? '',
      description: map['description'],
      releaseDate: map['releaseDate'] != null ? DateTime.parse(map['releaseDate']) : null,
      score: map['score'] ?? 5,
      imagePath: map['imagePath'],
      memeImage: map['memeImage'],  // Add this line
    );
  }
}
