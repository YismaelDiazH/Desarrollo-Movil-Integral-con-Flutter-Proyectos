import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      /* body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("Test1"),
            //SizedBox(height: 12,),
            //Spacer(), // forma de separar con ROW
            //formas de separar pero solo con ROW
            //Expanded(flex: 12, child: Container(height: 40,color: Colors.pink,)),
            //Expanded(child:   Container(height: 40,color: const Color.fromARGB(255, 175, 38, 217),)),
            Text("Test2"),
            Text("Test3"),
          ],
         
        ),
      ), */
      body: SingleChildScrollView(
        //evita overflow cuando el numero de elementos crecen
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .stretch, //va a estirar los hijos horizontalmente
          children: [
            Text(
              "1) Column basico",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(10),
              color: Color.fromARGB(255, 255, 156, 242),
              height: 100,
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .end, //Arriba, como este esta contenido no se puede mover
                crossAxisAlignment: CrossAxisAlignment
                    .center, //A la izquierda o derecha con end o center, este se puede mover por que  esta contenido
                children: <Widget>[
                 // Icon(Icons.access_alarm),
                 Expanded(flex:1,child: Container(color: Colors.red.shade100,)),
                 Expanded(flex:2,child: Container(color: Colors.green.shade100,)),
                 // Text("A"), Text("B"),Text("C"),
                ],
              ),
            ),
            SizedBox(height: 12),
            Text("2) Row basico"),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("A"), Text("B"), Text("C")],
              ),
            ),
          ],
        ),
      ),
    );
  }
}