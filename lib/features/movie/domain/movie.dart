class Movie {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? originalLanguage;
  String? originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String releaseDate;
  String title;
  bool? video;
  num? voteAverage;
  int voteCount;

  Movie(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      required this.id,
      this.originalLanguage,
      this.originalTitle,
      required this.overview,
      required this.popularity,
      this.posterPath,
      required this.releaseDate,
      required this.title,
      this.video,
      this.voteAverage,
      required this.voteCount});

  Movie.fromJson(Map<String, dynamic> json)
      : popularity = json['popularity'] ?? 0,
        title = json['title'] ?? '',
        voteCount = json['vote_count'] ?? 0,
        releaseDate = json['release_date'] ?? '',
        id = json['id'],
        overview = json['overview'] {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];

    posterPath = json['poster_path'];

    video = json['video'];
    voteAverage = json['vote_average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
