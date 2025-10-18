// task.dart

class Task {
  String title;       // Cada tarea tiene un título.
  bool isCompleted; // Y un estado para saber si está completada o no.

  // Constructor para crear una nueva tarea.
  // Por defecto, una nueva tarea no está completada.
  Task(this.title, {this.isCompleted = false});
}