import 'package:cinemapedia/domain/entities/movie.dart';

/// el repositorio es quien me permite cambiar de datasource.
//   Es la clase "que se usa en el resto de la app".
//    API KEY 23850f9eb175d268fcbbaef32e2b6bf6
///

abstract class MoviesRepository {

  Future<List<Movie>> getNowPlaying({ int page = 1 });

  // vamos a necesitar la misma funcion para obtener los Populares
  Future<List<Movie>> getPopular({ int page = 1 });

  //funcion para obtener las peliculas topRated
  Future<List<Movie>> getTopRated({ int page = 1 });

  //funcion para obtener las peliculas upcoming
  Future<List<Movie>> getUpcoming({ int page = 1 });

  //vamos a obtener los detalles de la pelicula
  Future<Movie> getMovieById(String id);

  //  Future<List<Movie>> searchMovies(String query);
}