import 'package:dio/dio.dart';
import '../models/place.dart';

class PlacesApi {
  // CAMBIA ESTA URL POR LA IP DE TU COMPUTADORA
  // Ejemplo: "http://192.168.1.100:8080"
  final Dio _dio = Dio(
    BaseOptions(
      //http://10.174.40.186:8082/places
      baseUrl: "http://192.168.100.14:8082", // Para emulador Android
      // baseUrl: "http://TU_IP:8080", // Para dispositivo físico
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  Future<List<Place>> getPlaces() async {
    try {
      final response = await _dio.get("/places");
      final data = response.data as List;
      return data.map((json) => Place.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Error al obtener lugares: $e");
    }
  }

  Future<Place> createPlace(
    String name,
    String description,
    double lat,
    double lng,
  ) async {
    try {
      final response = await _dio.post(
        "/places",
        data: {
          "name": name,
          "description": description,
          "lat": lat,
          "lng": lng,
        },
      );
      return Place.fromJson(response.data);
    } catch (e) {
      throw Exception("Error al crear lugar: $e");
    }
  }

  Future<void> deletePlace(String id) async {
    try {
      await _dio.delete("/places/$id");
    } catch (e) {
      throw Exception("Error al eliminar lugar: $e");
    }
  }
}
