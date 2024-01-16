import 'package:flutter/material.dart';

class SearchMovieDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
      return [
        IconButton(
          onPressed: () {
            print("click en sunny icon");
            
          },
          icon: const Icon(Icons.sunny),
        ),
      ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        print("click en back icon");
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
   return Container(
     color: Colors.red,
     child: Center(
       child: Text("build results"),
     )
   );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   return const Center(
     child: Text("build suggestions"),
   );
  }


}