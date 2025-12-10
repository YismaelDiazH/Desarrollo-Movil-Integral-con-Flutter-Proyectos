Ubícate App - La app que te ubica
=================================

"Ubícate App" es una aplicación móvil desarrollada en **Flutter** para gestionar y visualizar ubicaciones geográficas (lugares) mediante un mapa. Permite a los usuarios listar, agregar y eliminar lugares, y verlos individualmente o en conjunto en Google Maps.



🚀 Cómo Empezar
---------------

Este proyecto consta de dos partes principales: el **Servidor API (Backend)** y la **Aplicación Cliente (Flutter)**.

### 1\. Requisitos Previos

Asegúrate de tener instalado y configurado:

*   **Flutter SDK** (Versión 3.x o superior recomendada).
    
*   **Google Maps API Key** (Obligatoria para que los mapas se muestren).
    
*   **Servidor Backend** (Un servicio REST que exponga los datos de los lugares).
    

### 2\. Levantar el Servidor API (Backend)

Es crucial que el servidor esté activo y accesible para la aplicación cliente.

**Parámetro**

**Detalle Requerido**

**Puerto Requerido**

**8082**

**Base URL**

http://:8082

**Comando de Ejecución**

Varía según el framework de tu servidor (ej. node index.js, mvn spring-boot:run, etc.).

> **⚠️ ¡Advertencia de Configuración de Red!** La aplicación está actualmente configurada con la IP **192.168.100.14** en lib/services/places\_api.dart. Si estás usando un dispositivo físico o un emulador diferente, **debes actualizar esta IP a la dirección IP de tu máquina host.**

### 3\. Levantar la Aplicación Flutter (Cliente)

1.  flutter pub get
    
2.  **Configurar Google Maps:**
    
    *   Verifica que tu clave de Google Maps API esté configurada en los archivos nativos (android/AndroidManifest.xml, ios/AppDelegate.swift) y en web/index.html.
        
    *   **Importante:** Asegúrate de haber habilitado las APIs Maps JavaScript API, Maps SDK for Android, y Maps SDK for iOS en la Consola de Google Cloud para evitar el error ApiNotActivatedMapError.
        
3.  flutter run
    

⚙️ Estructura del API (Endpoints)
---------------------------------

La aplicación utiliza la librería Dio para comunicarse con la API en el puerto 8082 a través de los siguientes endpoints:

**Método**

**Endpoint**

**Descripción**

**Función en Flutter**

GET

/places

Obtiene la lista completa de todos los lugares registrados.

PlacesApi.getPlaces()

POST

/places

Crea un nuevo lugar. Requiere el cuerpo JSON con name, description, lat, y lng.

PlacesApi.createPlace()

DELETE

/places/{id}

Elimina el lugar cuyo ID coincida con el parámetro de ruta.

PlacesApi.deletePlace()

📁 Archivos de Vistas Clave
---------------------------

**Archivo**

**Descripción**

lib/screens/home\_screen.dart

Pantalla de bienvenida y navegación principal.

lib/screens/places\_list\_screen.dart

Muestra la lista de lugares, permite refrescar y navegar al mapa grupal o individual.

lib/screens/add\_place\_screen.dart

Formulario para la creación de nuevos lugares.

lib/screens/place\_map\_screen.dart

Componente de Google Maps que visualiza los marcadores de los lugares.

lib/services/places\_api.dart

Clase de servicio que gestiona la conexión HTTP (DIO) con el backend.