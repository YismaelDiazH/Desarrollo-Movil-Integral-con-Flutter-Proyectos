import 'package:dio/dio.dart';

class ApiService{
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: Duration(seconds: 5), // Tiempo de espera para la conexión
    receiveTimeout: Duration(seconds: 5), // Tiempo de espera para la recepción de datos
  ));

  Future<List<dynamic>> getUsers() async{
    try {
      final response = await _dio.get('/users');
      return response.data;

    } on DioError catch(e) {
      print("Error: ${e.message}");
      return [];
    }
  }

  /*Colocamos el async porque indica que la funcion hara una operacion asincrona 
  y devolvera un Future que tiene dos posibilidades, que se complete con exito o con error.
  Future es como una promesa que indica que recibiremos algo en el futuro, pero sin saber 
  con exactitud cuando o que (en este caso por el future un error o lo que trae la peticion).

  Await se utiliza para esperar a que una operacion asincrona se complete antes de continuar
  */

  /* Future<List<dynamic>> getPosts() async{
    try {
      final response = await _dio.get('/posts');
      return response.data;

    } on DioError catch(e) {
      print("Error: ${e.message}");
      return [];
    }
  } */
}