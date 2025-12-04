import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'notifications_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Pedir permisos (iOS y algunos Android)
  await FirebaseMessaging.instance.requestPermission();

  // Mostrar token en consola
  final token = await FirebaseMessaging.instance.getToken();
  print("TOKEN FCM: $token");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notificaciones Firebase',
      home: const NotificationsPage(),
    );
  }
}
