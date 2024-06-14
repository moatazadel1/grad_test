import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(29.076360, 31.097000),
          zoom: 12,
        ),
        markers: {
          const Marker(
            markerId: MarkerId('1'),
            position: LatLng(29.076360, 31.097000),
            infoWindow: InfoWindow(title: 'Beni Suef University'),
          ),
        },
      ),
    );
  }
}