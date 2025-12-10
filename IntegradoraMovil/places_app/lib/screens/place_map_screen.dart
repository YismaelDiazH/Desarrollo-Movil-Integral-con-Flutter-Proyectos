import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

const Color _primaryColor = Color(0xFF8B0000); 

class PlacesMapScreen extends StatefulWidget {
  final Place? place; 
  final List<Place>? places; 

  const PlacesMapScreen({super.key, this.place, this.places})
      : assert(
          place != null || places != null,
          "Debes proporcionar los dados correctamente",
        );

  @override
  State<PlacesMapScreen> createState() => _PlacesMapScreenState();
}

class _PlacesMapScreenState extends State<PlacesMapScreen> {
  late GoogleMapController _mapController;
  late Set<Marker> _markers;
  late CameraPosition _initialPosition;

  @override
  void initState() {
    super.initState();
    _setupMap();
  }

  void _setupMap() {
    _markers = {};

    if (widget.place != null) {
      
      final place = widget.place!;
      _initialPosition = CameraPosition(
        target: LatLng(place.lat, place.lng),
        zoom: 15,
      );
      _markers.add(
        Marker(
          markerId: MarkerId(place.id),
          position: LatLng(place.lat, place.lng),
          infoWindow: InfoWindow(title: place.name, snippet: place.description),
        ),
      );
    } else if (widget.places != null && widget.places!.isNotEmpty) {
     
      for (var place in widget.places!) {
        _markers.add(
          Marker(
            markerId: MarkerId(place.id),
            position: LatLng(place.lat, place.lng),
            infoWindow: InfoWindow(
              title: place.name,
              snippet: place.description,
            ),
          ),
        );
      }

      double avgLat = widget.places!.map((p) => p.lat).reduce((a, b) => a + b) /
          widget.places!.length;
      double avgLng = widget.places!.map((p) => p.lng).reduce((a, b) => a + b) /
          widget.places!.length;

      _initialPosition = CameraPosition(
        target: LatLng(avgLat, avgLng),
        zoom: 12,
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.place != null ? widget.place!.name : "Mapa de Lugares",
        ),
        backgroundColor: _primaryColor, // Color vino
        foregroundColor: Colors.white,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: _initialPosition,
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        zoomControlsEnabled: true,
      ),
      floatingActionButton: widget.places != null && widget.places!.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                // Ajustar zoom para ver todos los marcadores
                _mapController.animateCamera(
                  CameraUpdate.newCameraPosition(_initialPosition),
                );
              },
              label: const Text("Ver todos"),
              icon: const Icon(Icons.center_focus_strong),
              backgroundColor: _primaryColor, // Color vino
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Bordes redondeados sutiles
              ),
            )
          : null,
    );
  }
}