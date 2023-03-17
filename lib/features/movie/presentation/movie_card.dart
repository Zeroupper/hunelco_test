import 'package:flutter/material.dart';
import 'package:hunelco_test/features/movie/domain/movie.dart';
import 'package:hunelco_test/features/movie/presentation/movie_detail_screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MovieDetailScreen.routeName, arguments: movie.id);
      },
      child: ClipRRect(
        clipBehavior: Clip.none,
        borderRadius: BorderRadius.circular(40.0),
        child: Card(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(8.0),
          elevation: 4.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              movie.posterPath != null
                  ? SizedBox(
                      height: 200,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500/${movie.posterPath!}',
                        fit: BoxFit.fitHeight,
                      ))
                  : const SizedBox.shrink(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        children: [
                          IconWithVotes(
                            icon: Icons.star,
                            count: movie.voteCount,
                            iconColor: Colors.yellow,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          IconWithVotes(
                            icon: Icons.favorite,
                            count: movie.popularity,
                            iconColor: Colors.red,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        movie.overview,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IconWithVotes extends StatelessWidget {
  final IconData icon;
  final num count;
  final Color? iconColor;

  const IconWithVotes({super.key, required this.icon, required this.count, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        Text(count.toString())
      ],
    );
  }
}
