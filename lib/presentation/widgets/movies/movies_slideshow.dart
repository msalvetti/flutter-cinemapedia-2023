import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: double.infinity, //para que ocupe todo el ancho posible
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.8,
        autoplay: true,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _Slide(movie: movie);
        },
        itemCount: movies.length,
      ),
    );
  }
}

// tenemos que seguir trabajando con la UI de este widget.
class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage("https://wowslider.com/sliders/demo-31/data1/images/bench560435.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
