import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';
 
 final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
                
        return  HomeScreen(
             pageIndex: int.parse(state.params['page'] ?? '0'),
        );

      },
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
    path: '/',
    redirect: (_ , __ ) => '/home/0',
    )
  ]
);