// add_task_page.dart

import 'package:flutter/material.dart';

// Es un StatefulWidget porque necesita un Controller, que es un objeto que "mantiene un estado".
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  // Controlador para leer el texto que el usuario escribe en el TextField.
  // Exactamente como en el Proyecto 1 para el nombre del estudiante.
  final TextEditingController _taskController = TextEditingController();

  void _saveTask() {
    final taskTitle = _taskController.text.trim();

    // Verificamos que el usuario realmente haya escrito algo.
    if (taskTitle.isNotEmpty) {
      // Navigator.pop se usa para CERRAR la pantalla actual y regresar a la anterior.
      // El segundo argumento, 'taskTitle', es un DATO que le enviamos de vuelta
      // a la pantalla que nos abrió (la HomePage).
      Navigator.pop(context, taskTitle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Añadir Nueva Tarea"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // El campo de texto para ingresar la nueva tarea.
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: "Título de la tarea",
                border: OutlineInputBorder(),
              ),
              // Esto hace que al presionar "Enter" en el teclado, la tarea se guarde.
              onSubmitted: (_) => _saveTask(),
            ),
            const SizedBox(height: 20),
            // Botón para guardar la tarea.
            ElevatedButton(
              onPressed: _saveTask,
              child: const Text("Guardar Tarea"),
            ),
          ],
        ),
      ),
    );
  }
}