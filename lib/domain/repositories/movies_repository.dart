import 'package:cinemapedia/domain/entities/movie.dart';


abstract class MoviesRepository {

  Future<List<Movie>> getNowPlaying({ int page = 1 });

  // vamos a necesitar la misma funcion para obtener los Populares
  Future<List<Movie>> getPopular({ int page = 1 });

  //funcion para obtener las peliculas topRated
  Future<List<Movie>> getTopRated({ int page = 1 });

  //funcion para obtener las peliculas upcoming
  Future<List<Movie>> getUpcoming({ int page = 1 });

  //vamos a obtener los detalles de la pelicula
  Future<Movie> getMovieDetails({ required String movieId });
}