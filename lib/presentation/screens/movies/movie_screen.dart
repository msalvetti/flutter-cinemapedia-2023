import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  static const name = 'movie-screen';

  final String movieId;
  const MovieScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {

  //generamos el metodo initState
  @override
  void initState() {
    super.initState();
    print('MovieScreen: ${widget.movieId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Screen ${widget.movieId}'),
      ),
          
      body: Container(),
    );
  }
}
