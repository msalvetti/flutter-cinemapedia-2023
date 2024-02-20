import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';
 
 final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    //vamos a crear nuevas rutas con ShellRoute y su configuracion
    ShellRoute(
       builder: (context, state, child) => HomeScreen(childView: child,),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeView(),
            routes: [
              GoRoute(
                path: 'movie/:movieId',
                name: MovieScreen.name,
                builder: (context, state) => MovieScreen(
                  movieId: state.params['movieId'] ?? 'no-id',
                ),
              ),
            ], 
          ),
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const FavoritesView(),
          ) 
        ],
      )

    // rutas padre-hijo
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen(childView: HomeView(),),
    //   routes: [
    //     GoRoute(
    //       path: 'movie/:movieId',
    //       name: MovieScreen.name,
    //       builder: (context, state) => MovieScreen(
    //         movieId: state.params['movieId'] ?? 'no-id',
    //       ),
    //     ),
    //   ],
    // ),
   
  ]
);