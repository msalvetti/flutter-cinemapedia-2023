import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

//vamos a crear ahora un Provider para las peliculas previamente buscadas.
final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);

  return SearchedMoviesNotifier(
    searchMovies: movieRepository.searchMovies,
    ref: ref,
  );
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMovies;
  final Ref ref;

  //estado inicial, un arreglo vacio
  SearchedMoviesNotifier({
    required this.searchMovies,
    required this.ref,
  }) : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;
    return state;
  }
}