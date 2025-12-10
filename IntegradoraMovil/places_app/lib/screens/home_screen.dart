import 'package:flutter/material.dart';
import 'places_list_screen.dart';
import 'add_place_screen.dart';

const Color _primaryColor = Color(0xFF8B0000); 
const Color _accentColor = Color(0xFFB22222); 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubícate App - La app que te ubica"),
        backgroundColor: _primaryColor, 
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              Image.asset(
                'map_pin_icon.png', 
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.location_on, 
                  size: 100, 
                  color: _primaryColor, 
                ),
              ),
              
              const SizedBox(height: 20),
              const Text(
                "Ubícate App - La app que te ubica",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _primaryColor), 
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlacesListScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.list),
                  label: const Text("Ver lugares"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor, 
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), 
                    ),
                    elevation: 5,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPlaceScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_location),
                  label: const Text("Agregar lugar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accentColor, 
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), 
                    ),
                    elevation: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}