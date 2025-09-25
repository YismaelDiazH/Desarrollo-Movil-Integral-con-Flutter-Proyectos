import 'package:ejercicio3/main.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget{
  const SecondPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("This is the second page"),),
      body: Center(
        child: Column(
mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            SizedBox(height: 15,),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context, 
              MaterialPageRoute(builder: (context)=>MyApp()));
            }, child: Text("Go to Home page"))
          ],
        ),
      
      
    ));
  }
  
}