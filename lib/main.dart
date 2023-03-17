import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunelco_test/features/movie/data/the_movie_db_repository.dart';
import 'package:hunelco_test/features/movie/presentation/movie_detail_screen.dart';
import 'package:hunelco_test/features/movie/presentation/movie_home_screen.dart';

void main() async {
  final TheMovieDbRepository repository = await TheMovieDbRepository().initialize();

  runApp(
    ProviderScope(
      overrides: [
        movieDbRepositoryProvider.overrideWithValue(repository),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hunelco test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == MovieDetailScreen.routeName) {
          final movieId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) {
              return MovieDetailScreen(
                movieId: movieId,
              );
            },
          );
        }
        return null;
      },
      home: const MovieHomeScreen(),
    );
  }
}
