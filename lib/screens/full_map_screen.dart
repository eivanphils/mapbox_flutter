import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FullMapScreen extends StatefulWidget {
  static const mapboxToken =
      'pk.eyJ1IjoiZWl2YW5waGlscyIsImEiOiJjbG5sdHNyMncwZHZ0MnVycWY4eWdzZWJpIn0.4Z4q2se2miXGZD_OG5V3Gg';

  const FullMapScreen({Key? key}) : super(key: key);

  @override
  State<FullMapScreen> createState() => _FullMapScreenState();
}

class _FullMapScreenState extends State<FullMapScreen> {
  final center = const LatLng(-33.479720, -70.599370);

  String selectedStyle = 'mapbox/light-v11';
  final String darkStyle = 'mapbox/dark-v11';
  final String lightStyle = 'mapbox/light-v11';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _CreateMapbox(center: center, selectedStyle: selectedStyle),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
            onPressed: () {
              selectedStyle =
                  selectedStyle == lightStyle ? darkStyle : lightStyle;
              setState(() {});
            },
            child: const Icon(Icons.change_circle))
      ]),
    );
  }
}

class _CreateMapbox extends StatelessWidget {
  const _CreateMapbox({
    super.key,
    required this.center,
    required this.selectedStyle,
  });

  final LatLng center;
  final String selectedStyle;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
        options: MapOptions(
            initialCenter: center, minZoom: 5, maxZoom: 25, initialZoom: 18),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
            additionalOptions: {
              'accessToken': FullMapScreen.mapboxToken,
              'id': selectedStyle
            },
          ),
          MarkerLayer(markers: [
            Marker(
                point: center,
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.cyanAccent,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Icon(
                      Icons.abc,
                      size: 30,
                    )))
          ])
        ]);
  }
}
