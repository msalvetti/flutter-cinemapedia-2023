import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';

class MovieHorizontalListview extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null || subTitle != null)
            _Title(title: title, subTitle: subTitle),
          Expanded(
            child: ListView.builder(
              //  controller: scrollController,
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, int index) => _Slide(movie: movies[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(
                subTitle!,
              ),
            )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Imagen
            SizedBox(
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  width: 150,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2)),
                      );
                    }
                    return GestureDetector(
                      onTap: () => context.push('/home/0/movie/${movie.id}'),
                      child: FadeIn(child: child),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
           
            //* Titulo
            const SizedBox(height: 5),
            SizedBox(
              width: 150,
              child: Text(
                  movie.title,
                  maxLines: 2,
                  style: textStyle.titleSmall,
                ),
            ),
           
            //* Estrellas
            SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Icon(
                      Icons.star_half_outlined,
                      color: Colors.yellow.shade800,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${movie.voteAverage}',
                      style: textStyle.bodyMedium
                          ?.copyWith(color: Colors.yellow.shade800),
                    ),
                    const SizedBox(width: 3),
                    const Spacer(),
                    Text(
                      '${movie.popularity}',
                      style: textStyle.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                )),
          ],
        ));
  }
}