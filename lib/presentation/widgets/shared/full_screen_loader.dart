import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({Key? key}) : super(key: key);

// metodo que retorna un stream que emite un mensaje cada 1 segundo
  Stream<String> getStream() {
    final messages = <String>[
      'Loading...',
      'Still loading...',
      'Please wait...',
      'Almost there...',
      'Just a moment...',
      'Loading is taking longer than expected...',
    ];

    return Stream.periodic(const Duration(seconds: 1), (x) => messages[x])
        .take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // center vertically
        children: [
          const Text('Loading...'),
          const SizedBox(height: 20),
          CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 20),
          StreamBuilder(
            stream: getStream(),
            builder: (context, snapshot) {
              return Text(snapshot.data ?? 'Welcome!');
            },
          )
        ],
      ),
    );
  }
}
