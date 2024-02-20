import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationBar({super.key, required this.currentIndex});


  void onItemTapped(BuildContext context, int index) {
    print('CustomBottomNavigationBar: onItemTapped: $index');
    //using context.go to navigate to the different pages based on index value.
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
        break;
      default:
        context.go('/home/0');
    }

  }

  @override
  Widget build(BuildContext context) {
    print('CustomBottomNavigationBar: currentIndex: $currentIndex');

    return BottomNavigationBar(
      onTap: (index) => onItemTapped(context, index),
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Categorias',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
