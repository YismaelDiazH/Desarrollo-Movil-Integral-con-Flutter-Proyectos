import 'package:flutter/material.dart';
import '../services/places_api.dart';

// Paleta de colores elegante
const Color _primaryColor = Color(0xFF8B0000); // Rojo Oscuro / Vino
const Color _accentColor = Color(0xFFB22222); // Rojo Ladrillo para acentos

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  final PlacesApi _api = PlacesApi();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  Future<void> _savePlace() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    final latText = _latController.text.trim();
    final lngText = _lngController.text.trim();

    final lat = double.tryParse(latText);
    final lng = double.tryParse(lngText);

    if (lat == null || lng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Latitud/longitud no válidas")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _api.createPlace(name, description, lat, lng);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Ubicación fijada!"),
            backgroundColor: Colors.grey,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Lugar"),
        backgroundColor: _accentColor, 
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nombre del lugar",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.place),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: _primaryColor, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Por favor ingresa un nombre";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Descripción",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.description),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: _primaryColor, width: 2.0),
                  ),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Por favor ingresa una descripción";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _latController,
                decoration: InputDecoration(
                  labelText: "Latitud",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.my_location),
                  hintText: "20.159168587620847",
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: _primaryColor, width: 2.0),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Por favor ingresa la latitud";
                  }
                  if (double.tryParse(value) == null) {
                    return "Ingresa un número válido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lngController,
                decoration: InputDecoration(
                  labelText: "Longitud",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.location_searching),
                  hintText: "-104.01458127567592",
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: _primaryColor, width: 2.0),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Por favor ingresa la longitud";
                  }
                  if (double.tryParse(value) == null) {
                    return "Ingresa un número válido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _savePlace,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.save),
                label: Text(_isLoading ? "Guardando..." : "Guardar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accentColor, // Color de acento
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Bordes redondeados sutiles
                  ),
                  elevation: 5,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}