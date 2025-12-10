import 'package:flutter/material.dart';
import '../models/place.dart';
import '../services/places_api.dart';
import '../screens/place_map_screen.dart';

const Color _primaryColor = Color(0xFF8B0000); 
const Color _accentColor = Color(0xFFB22222); 

class PlacesListScreen extends StatefulWidget {
  const PlacesListScreen({super.key});

  @override
  State<PlacesListScreen> createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  final PlacesApi _api = PlacesApi();
  List<Place> _places = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  Future<void> _loadPlaces() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final places = await _api.getPlaces();
      setState(() {
        _places = places;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _deletePlace(String id) async {
    try {
      await _api.deletePlace(id);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Lugar eliminado")));
      _loadPlaces();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error al eliminar: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Lugares"),
        backgroundColor: _primaryColor, 
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh), onPressed: _loadPlaces),
          if (_places.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.map),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlacesMapScreen(places: _places),
                  ),
                );
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: _primaryColor)) 
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 60, color: _accentColor), 
                      const SizedBox(height: 16),
                      Text(
                        "Error: $_errorMessage",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: _accentColor),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadPlaces,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text("Reintentar"),
                      ),
                    ],
                  ),
                )
              : _places.isEmpty
                  ? const Center(child: Text("No hay lugares registrados"))
                  : ListView.builder(
                      itemCount: _places.length,
                      itemBuilder: (context, index) {
                        final place = _places[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          elevation: 3, 
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: _primaryColor, 
                              child: Icon(Icons.place, color: Colors.white),
                            ),
                            title: Text(
                              place.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333)), 
                            ),
                            subtitle: Text(place.description),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.map,
                                      color: _accentColor), 
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PlacesMapScreen(place: place),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Confirmar"),
                                        content:
                                            Text("¿Eliminar ${place.name}?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("Cancelar", style: TextStyle(color: Colors.black54)),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _deletePlace(place.id);
                                            },
                                            child: const Text("Eliminar", style: TextStyle(color: Colors.red)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}