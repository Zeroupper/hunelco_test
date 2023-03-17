import 'dart:developer';

import 'package:hunelco_test/features/movie/data/the_movie_db_repository.dart';
import 'package:hunelco_test/features/movie/domain/movie.dart';
import 'package:hunelco_test/features/movie/domain/movie_detailed.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod/riverpod.dart';

final movieControllerProvider = StateNotifierProvider.autoDispose<MovieContoller, void>((ref) {
  return MovieContoller(movieRepository: ref.watch(movieDbRepositoryProvider));
});

class MovieContoller extends StateNotifier<void> {
  final TheMovieDbRepository movieRepository;

  MovieContoller({required this.movieRepository}) : super([]);

  Future<List<Movie>> getMoviesByQuery({required int page, required String query}) async {
    try {
      final movies = await movieRepository.getMovies(page: page, query: query);
      return movies;
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return [];
    }
  }

  Future<MovieDetailed?> getMovieById({required int movieId}) async {
    try {
      return movieRepository.getMovieById(movieId: movieId);
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return null;
    }
  }

  Future<void> fetchPage({required int pageKey, required String query, required PagingController pagingController}) async {
    try {
      const pageSize = 20;

      final newItems = await getMoviesByQuery(page: pageKey, query: query);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}
