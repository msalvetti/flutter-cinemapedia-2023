import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';
 
 final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
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
   
  ]
);