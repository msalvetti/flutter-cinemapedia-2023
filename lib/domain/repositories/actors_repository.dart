

import 'package:cinemapedia/domain/entities/Actor.dart';

abstract class ActorsRepository {
 
  Future<List<Actor>> getActorsByMovie(String movieId);

}
