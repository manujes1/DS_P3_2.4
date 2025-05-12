import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  final String title; 
  final Function function; 
  const Boton({super.key, required this.title, required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ElevatedButton(
          onPressed: (){
            function();
          }, 
          child: Text(title)),
      ),
    );
  }
}