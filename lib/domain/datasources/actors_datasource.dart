import 'package:cinemapedia/domain/entities/Actor.dart';

/// This is an abstract class representing a datasource for actors.
abstract class ActorsDatasource {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
