import 'package:cinemapedia/domain/entities/movie.dart';


abstract class MoviesDatasource {

  Future<List<Movie>> getNowPlaying({ int page = 1 });

  //vamos a crear un metodo para obtener las peliculas populares
  Future<List<Movie>> getPopular({ int page = 1 });

  //vamos a crear un metodo para obtener las peliculas topRated
  Future<List<Movie>> getTopRated({ int page = 1 });

  //vamos a crear un metodo para obtener las peliculas upcoming
  Future<List<Movie>> getUpcoming({ int page = 1 });
  
}