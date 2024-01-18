import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  });

  void clearStreams() {
    debouncedMovies.close();
  //  isLoadingStream.close();
  }

  void _onQueryChanged(String query) async {
    isLoadingStream.add(true);
    
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoadingStream.add(false);
    });
  }

  @override
  String get searchFieldLabel => "Buscar pelicula";

  //por ahora vamos a poner un arrow para limpiar.
  //Luego podemos poner un icono de loading.
  @override
  List<Widget>? buildActions(BuildContext context) {

    // creamos un StreamBuilder con el stream de isLoadingStream
    // y mostramos un SpinPerfect si es broadcast o un FadeIn si no lo es
    // y en ambos casos un IconButton para limpiar la busqueda
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          final isLoading = snapshot.data ?? false;
          return isLoading
              ? SpinPerfect(
                  duration: const Duration(seconds: 20),
                  spins: 10,
                  infinite: true,
                  child: IconButton(
                    onPressed: () {
                      query = "";
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                )
              : FadeIn(
                  child: IconButton(
                    onPressed: () {
                      query = "";
                    },
                    icon: const Icon(Icons.clear),
                  ),
                );
        },
      ),
    ];
    }

  // buildLeading es lo que necesito para salir de la busqueda
  // y volver a la pantalla anterior, puedo usar el 2do parametro, llamado result
  // para pasarle el valor de la busqueda a la home (una Movie opcional)
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();

        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions(context);
  }

  // buildSuggestions es lo que se muestra cuando se hace una busqueda
  // y no se presiona enter, es decir, cuando se esta escribiendo. Tenemos que controlarlo.
  // Vamos a realizar la peticion a la api y mostrar los resultados, con MovieRepositoryImpl con Provider (searchMovie method)
  @override
  Widget buildSuggestions(BuildContext context) {
    //aqui vamos a hacer la peticion a la api con un gestor de estado
    //y vamos a mostrar los resultados en una lista
    _onQueryChanged(query);
    return buildResultsAndSuggestions(context);
  }

  Widget buildResultsAndSuggestions(BuildContext context) {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _MovieItem(
              movie: movie,
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }
}

// create a StatelesWidget named _MovieItem that receives a Movie as parameter
// and returns a ListTile with the movie information
class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              //  height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/images/no-image.jpeg'),
                  image: NetworkImage(movie.posterPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // description
            const SizedBox(width: 10),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  (movie.overview.length > 100)
                      ? Text(
                          movie.overview.substring(0, 100) + '...',
                          style: textStyles.titleSmall,
                        )
                      : Text(movie.overview, style: textStyles.titleSmall),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(HumanFormats.number(movie.voteAverage, 1),
                          style: textStyles.titleSmall!
                              .copyWith(color: Colors.yellow.shade900)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
