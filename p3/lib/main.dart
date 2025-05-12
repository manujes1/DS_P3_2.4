import 'package:flutter/material.dart';
import 'package:p3/class/bank_service.dart';
import 'package:p3/components/boton.dart';
import 'package:p3/views/list_acount.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio Grupal',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'BankService'),
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
  
  BankService bankService = BankService();

  void _createAccount(){
    setState(() {
      bankService.createAccount();
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar( 
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Boton(title : "Crear Cuenta", function: _createAccount,),
          Expanded(child: ListAcount(bankService: bankService)),
          ],
      ),
    );
  }
}
