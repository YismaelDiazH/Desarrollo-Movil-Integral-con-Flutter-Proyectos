import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String _lastTitle = 'Sin notificaciones';
  String _lastBody = '';

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;

      if (notification != null) {
        setState(() {
          _lastTitle = notification.title ?? 'Sin título';
          _lastBody = notification.body ?? 'Sin contenido';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Notificación: ${notification.title ?? 'Sin título'}'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
  final TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey[700], 
  );

  return Scaffold(
    appBar: AppBar(
      title: const Text("Notificaciones"),
      elevation: 2,
    ),
    body: SingleChildScrollView( 
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "> Última notificación recibida",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),

          Card(
            elevation: 0, 
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "> Título: $_lastTitle",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "> Contenido: $_lastBody",
                    style: subtitleStyle,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 30), 
Card(
            elevation: 0, 
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
          const Divider(
            height: 2,
            thickness: 1, // Grosor sutil
            indent: 10,
            endIndent: 10,
          ),
          const SizedBox(height: 25),


          const Text(
            "> Instrucciones",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),

          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.info_outline, color: Theme.of(context).primaryColor),
            title: const Text(
              "Pasos para enviar una notificación de prueba:",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "1. Primero abre Firebase Console → Cloud Messaging.\n"
                "2. Segundo, crea un mensaje de notificación.\n"
                "3. Después, envía un título y cuerpo.\n"
                "4. Mantén esta pantalla abierta para ver el SnackBar y el contenido.",
                style: TextStyle(fontSize: 15, height: 1.4), // Aumenta el espacio entre líneas
              ),
            ),
          ),
          const Divider(
            height: 2,
            thickness: 1, // Grosor sutil
            indent: 10,
            endIndent: 10,
          ),
         
                ],
              ),
            ),
          ),
          
        ],
      ),
    ),
  );
}
}
