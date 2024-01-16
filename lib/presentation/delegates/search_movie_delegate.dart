import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMovieCallback searchMovie;

  SearchMovieDelegate({required this.searchMovie});

  @override
  String get searchFieldLabel => "Buscar pelicula";

  //por ahora vamos a poner un arrow para limpiar.
  //Luego podemos poner un icono de loading.
  @override
  List<Widget>? buildActions(BuildContext context) {
    print('query: $query');
    return [
      if (query.isNotEmpty)
        FadeIn(
          child: IconButton(
            onPressed: () {
              query = "";
            },
            icon: const Icon(Icons.clear),
          ),
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
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("build results");
  }

  // buildSuggestions es lo que se muestra cuando se hace una busqueda
  // y no se presiona enter, es decir, cuando se esta escribiendo. Tenemos que controlarlo.
  // Vamos a realizar la peticion a la api y mostrar los resultados, con MovieRepositoryImpl con Provider (searchMovie method)
  @override
  Widget buildSuggestions(BuildContext context) {
    //aqui vamos a hacer la peticion a la api con un gestor de estado
    //y vamos a mostrar los resultados en una lista
    return FutureBuilder<List<Movie>>(
      initialData: const [],
      future: searchMovie(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data ?? [];
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                leading: FadeInImage(
                  placeholder: const AssetImage('assets/images/no-image.jpeg'),
                  image: NetworkImage(movie.backdropPath),
                  width: 50,
                  fit: BoxFit.contain,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: () {
                  close(context, movie);
                },
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
