import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';

class FullMapScreen extends StatefulWidget {
  static const mapboxToken =
      'pk.eyJ1IjoiZWl2YW5waGlscyIsImEiOiJjbG5sdHNyMncwZHZ0MnVycWY4eWdzZWJpIn0.4Z4q2se2miXGZD_OG5V3Gg';

  const FullMapScreen({Key? key}) : super(key: key);

  @override
  State<FullMapScreen> createState() => _FullMapScreenState();
}

class _FullMapScreenState extends State<FullMapScreen>
    with TickerProviderStateMixin {
  // MapController mapController = MapController();

  final center = const LatLng(-33.479720, -70.599370);
  late final _animatedMapController = AnimatedMapController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );

  String selectedStyle = 'mapbox/light-v11';
  final String darkStyle = 'mapbox/dark-v11';
  final String lightStyle = 'mapbox/light-v11';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _CreateMapbox(
        center: center,
        selectedStyle: selectedStyle,
        mapController: _animatedMapController.mapController,
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () {
            _animatedMapController.animatedZoomIn();
            // mapController.move(
            //     mapController.camera.center, mapController.camera.zoom + 1);
          },
          child: const Icon(Icons.zoom_in),
        ),
        const SizedBox(
          height: 5,
        ),
        FloatingActionButton(
          onPressed: () {
            _animatedMapController.animatedZoomOut();
            // mapController.move(
            //     mapController.camera.center, mapController.camera.zoom - 1);
          },
          child: const Icon(Icons.zoom_out),
        ),
        const SizedBox(
          height: 5,
        ),
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
  const _CreateMapbox(
      {super.key,
      required this.center,
      required this.selectedStyle,
      required this.mapController});

  final LatLng center;
  final String selectedStyle;
  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
        mapController: mapController,
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
                child: const Icon(
                  Icons.place,
                  size: 50,
                  color: Colors.deepPurpleAccent,
                ))
          ])
        ]);
  }
}
