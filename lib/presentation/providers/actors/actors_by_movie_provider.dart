import 'package:cinemapedia/domain/entities/Actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Vamos a crear un provier para la información de la película
///  MovieMapNotifier extendera de StateNotifier y la estructura de la clase sera la siguiente:

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String,List<Actor>>>((ref) {
  final actorRepository = ref.watch(actorRepositoryProvider);
  return ActorsByMovieNotifier(getActors: actorRepository.getActorsByMovie);
});

///
/// {
///  '12345': List<Actor>,
///  '12346': List<Actor>,
///  '12347': List<Actor>
/// }
/// este mapa sera el que nos permita almacenar la información de las peliculas como un cache.//

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state.containsKey(movieId)) return;
        
    final List<Actor> actors = await getActors(movieId);
    state = {
      ...state,
      movieId:actors,
    };
  }
}
