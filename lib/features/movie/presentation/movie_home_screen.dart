import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunelco_test/features/movie/domain/movie.dart';
import 'package:hunelco_test/features/movie/presentation/movie_card.dart';
import 'package:hunelco_test/features/movie/presentation/movie_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MovieHomeScreen extends ConsumerStatefulWidget {
  const MovieHomeScreen({super.key});

  @override
  ConsumerState<MovieHomeScreen> createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends ConsumerState<MovieHomeScreen> {
  final TextEditingController controller = TextEditingController();

  static const _pageSize = 20;

  final PagingController<int, Movie> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await ref.read(movieControllerProvider.notifier).getMoviesByQuery(page: pageKey, query: controller.text);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.removePageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: TextField(
                  onSubmitted: (v) => setState(
                    () {
                      _pagingController.refresh();
                    },
                  ),
                  textAlign: TextAlign.start,
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                  autofocus: false,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Search movies...',
                    hintStyle: theme.textTheme.titleMedium?.copyWith(color: Colors.white, height: 1.5),
                    border: InputBorder.none,
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          leading: const Icon(Icons.menu)),
      body: PagedListView<int, Movie>(
        pagingController: _pagingController,
        cacheExtent: 10,
        builderDelegate: PagedChildBuilderDelegate<Movie>(
          itemBuilder: (context, movie, index) => MovieCard(movie: movie),
        ),
      ),
    );
  }
}
