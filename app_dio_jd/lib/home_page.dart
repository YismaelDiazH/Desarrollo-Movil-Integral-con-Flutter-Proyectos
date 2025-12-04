import 'package:app_dio_jd/api_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget { //<- El StatefulWidget es para pintar una barra de carga mendiante un estado
  //cosntructor
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState()=>_HomePageState();
}

class _HomePageState extends State<HomePage>{
  final ApiService api = ApiService(); //<- Implemantacion del servicio ApiService
  List<dynamic> posts = []; //<- Lista para almacenar los posts obtenidos de la API (datos)
  bool loading = true; //<- Variable saber si cargan o no los datos

  @override
  void initState() {
    super.initState();
    //Cargar datos
    Load_Data();
  }

  //Creamos el metodo para que es de tipo Future que es lo que develve el ApiService
  Future<void> Load_Data() async{
    final data = await api.getUsers();
    setState(() {
      posts = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Demo con Dio"),),
      body: loading ? //<- Si loading es true muestra el CircularProgressIndicator
       Center(child: CircularProgressIndicator(),)
        :  //<- Si loading es false muestra la lista de datos obtenidos
        ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index){ //<- Utilizamos el mismo contexto de la aplicacion mas un index 
          final item=posts[index]; //<- Obtenemos el item de la lista posts en la posicion index
          return ListTile( //<- Creamos un ListTile para mostrar los datos
            title: Text(item['username']), //<- Mostramos el titulo del post
            subtitle: Text(item['email']), //<- Mostramos el cuerpo del post
          );
          }
        )
    );
  }

}