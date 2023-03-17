import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:hunelco_test/features/movie/domain/movie.dart';
import 'package:hunelco_test/features/movie/domain/movie_detailed.dart';
import 'package:riverpod/riverpod.dart';

final movieDbRepositoryProvider = Provider<TheMovieDbRepository>(
  (ref) => throw UnimplementedError(),
);

class TheMovieDbRepository {
  final String apiKey = '1b2ebef24b42da2c2eb14b613afaaae7';
  final String endpoint = 'https://developers.themoviedb.org/3/';

  final List<Movie> _movies = [];

  get movies => _movies;

  TheMovieDbRepository();

  Future<TheMovieDbRepository> initialize() async {
    await getMovies(page: 1, query: '');
    return this;
  }

  Future<List<Movie>> getMovies({required int page, required String query}) async {
    Response response;
    if (query.isEmpty) {
      response = await http.get(Uri.parse('https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page'));
    }else {
      response = await http.get(Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query&page=$page'));
    }
    
    if (response.statusCode == 200) {
      final movies = json.decode(response.body)['results'] as List<dynamic>;

      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieDetailed> getMovieById({required int movieId}) async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final parsedMovie = json.decode(response.body);

      return MovieDetailed.fromJson(parsedMovie);
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
