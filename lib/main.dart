import 'package:flutter/material.dart';
import 'package:mapbox_flutter/screens/full_map_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MapBox',
      home: Scaffold(
        body: FullMapScreen(),
      ),
    );
  }
}