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


  final List<int> _historial = [];
  bool _mostratHistorial = false;

  final List<String> students = ["alumno1", "alumno2", "alumno3"];

  void _incrementCounter() {
    setState(() {
      _counter++;
    _historial.add(_counter);
    });
  }

  void _showHistory(){
    setState(() {
      if(_mostratHistorial){
        _mostratHistorial = false;
      }
      else{
        _mostratHistorial = true;
      }
    });
  }

  void _deleteHistory(){
    setState(() {
      _counter=0;
    _historial.clear();
    });
  }

  void _lowerCounter() {
    setState(() {
      _counter--;
      
      if (_counter < 0) {
        _counter = 0;
        
      }
      _historial.add(_counter);

    });
  }


  Widget _getAllValues() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Historial de números:", 
        style: TextStyle(fontWeight: FontWeight.bold)
      ),
      const SizedBox(height: 8),
      
     
      
      _historial.isEmpty
          ? const Text("No hay historial") 
          : Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _historial.map((n) => Text("- $n")).toList(),
            ),
    ],
  );
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('---------------------------------------------------------------------------------------------'),
            const Text('You have pushed the button this many times:'),
            const Text('------------------------------------------------------------------------'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text('------------------------------------------------------------------------'),
          if(_mostratHistorial)_getAllValues(),
            const Text('------------------------------------------------------------------------'),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _lowerCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: _deleteHistory,
            tooltip: 'Delete',
            child: const Icon(Icons.delete),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: _showHistory,
            tooltip: 'Show',
            child: const Icon(Icons.remove_red_eye),
          ),
        ],
      ),
    );
  }
}
