// main.dart

import 'package:flutter/material.dart';
import 'add_task_page.dart'; // Importamos la segunda pantalla.
import 'task.dart';         // Importamos el modelo de datos.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tareas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Mis Tareas'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ===== VARIABLES DE ESTADO (Conceptos de Proyecto 1 y 2) =====

  // 1. La lista de objetos que se mostrará en la UI. Como la lista 'students'.
  final List<Task> _tasks = [];

  // 2. Una bandera booleana para mostrar/ocultar la lista. Como '_mostratHistorial'.
  bool _showTaskList = true;

  // ===== MÉTODOS Y LÓGICA =====

  // Este método navega a la pantalla de añadir tarea.
  // Usa 'async' y 'await' porque necesita ESPERAR a que la segunda pantalla se cierre
  // para recibir el dato que esta le envía.
  void _navigateAndAddTask() async {
    // Navigator.push abre la nueva pantalla.
    // ESPERA (await) aquí hasta que se ejecute un Navigator.pop en AddTaskPage.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskPage()),
    );

    // Cuando AddTaskPage se cierra, el 'result' será el título de la tarea que enviamos.
    // Si el usuario simplemente regresó sin guardar, 'result' será nulo.
    if (result != null && result is String) {
      // Usamos setState para modificar la lista y refrescar la UI (Concepto Proyecto 1).
      setState(() {
        _tasks.add(Task(result));
      });
    }
  }

  // Método para cambiar el estado de una tarea (completada/no completada).
  void _toggleTaskStatus(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  // Método para cambiar la visibilidad de la lista (Concepto Proyecto 2).
  void _toggleTaskListVisibility() {
    setState(() {
      _showTaskList = !_showTaskList; // Invierte el valor booleano.
    });
  }

  // ===== CONSTRUCCIÓN DE LA UI =====

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        // Añadimos un botón en la AppBar para ocultar/mostrar la lista.
        actions: [
          IconButton(
            // El icono cambia dependiendo del estado de _showTaskList (Renderizado condicional).
            icon: Icon(_showTaskList ? Icons.visibility_off : Icons.visibility),
            onPressed: _toggleTaskListVisibility,
            tooltip: _showTaskList ? 'Ocultar lista' : 'Mostrar lista',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Tareas Pendientes:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // ===== RENDERIZADO CONDICIONAL (Concepto del Proyecto 2) =====
            // Si _showTaskList es true, mostramos la lista. Si no, mostramos un mensaje.
            if (_showTaskList)
              // Usamos Expanded para que el ListView ocupe todo el espacio vertical disponible.
              Expanded(
                // Si la lista está vacía, muestra un texto. Si no, muestra la lista.
                child: _tasks.isEmpty
                    ? const Center(
                        child: Text("¡No hay tareas! Añade una nueva."),
                      )
                    : ListView.builder(
                        itemCount: _tasks.length,
                        itemBuilder: (context, index) {
                          final task = _tasks[index];
                          return ListTile(
                            // El título de la tarea se tacha si está completada.
                            title: Text(
                              task.title,
                              style: TextStyle(
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            // Checkbox para marcar/desmarcar la tarea.
                            leading: Checkbox(
                              value: task.isCompleted,
                              onChanged: (bool? value) {
                                _toggleTaskStatus(index);
                              },
                            ),
                          );
                        },
                      ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "La lista de tareas está oculta.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
      // Botón flotante para navegar a la pantalla de añadir tarea (Concepto Proyecto 3).
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndAddTask,
        tooltip: 'Añadir Tarea',
        child: const Icon(Icons.add),
      ),
    );
  }
}