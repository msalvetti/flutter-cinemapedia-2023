import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_providers.dart';

//TODO: Fixear ese magic number , el 6.-
final moviesSlideshowProvider = Provider<List<Movie>>((ref) {

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    if (nowPlayingMovies.isNotEmpty) {
      return nowPlayingMovies.sublist(0,6);
    } else {
      return [];
    }

});

