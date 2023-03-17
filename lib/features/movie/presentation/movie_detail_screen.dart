import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunelco_test/features/movie/domain/movie_detailed.dart';
import 'package:hunelco_test/features/movie/presentation/movie_controller.dart';

class MovieDetailScreen extends ConsumerStatefulWidget {
  final int movieId;

  static const routeName = '/details';

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  ConsumerState<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {
  late final Future<MovieDetailed?> movieFuture;

  @override
  void initState() {
    movieFuture = ref.read(movieControllerProvider.notifier).getMovieById(movieId: widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: FutureBuilder(
        future: movieFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    'Loading movie details...',
                    style: theme.textTheme.titleMedium,
                  )
                ],
              ),
            );
          }
          if (snapshot.hasData) {
            final movie = snapshot.data;

            if (movie == null) const Center(child: Text('An unknown error happened, please try again!'));
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 500,
                  collapsedHeight: 100,
                  flexibleSpace: Image.network(
                    'https://image.tmdb.org/t/p/w500/${movie!.posterPath}',
                    fit: BoxFit.cover,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title!,
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          movie.originalTitle!,
                          style: theme.textTheme.titleMedium?.copyWith(fontStyle: FontStyle.italic),
                        ),
                        Text(movie.releaseDate.toString()),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          movie.overview!,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Revenue made: ${movie.revenue}',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 200.0,
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          return const Center(child: Text('An unknown error happened, please try again!'));
        },
      ),
    );
  }
}
