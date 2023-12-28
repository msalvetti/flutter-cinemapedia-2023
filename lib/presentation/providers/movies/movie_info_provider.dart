import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Vamos a crear un provier para la información de la película
///  MovieMapNotifier extendera de StateNotifier y la estructura de la clase sera la siguiente:

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String,Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);

  return MovieMapNotifier(getMovie: movieRepository.getMovieById);
});

///
/// {
///  '12345': Movie(),
///  '12346': Movie(),
///  '12347': Movie(),
/// }
/// este mapa sera el que nos permita almacenar la información de las peliculas como un cache.//

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state.containsKey(movieId)) return;
    //  if ( state[movieId] != null ) return;
    print('realizando la peticion');

    var movie = await getMovie(movieId);
    state = {
      ...state,
      movieId: movie,
    };
  }
}
