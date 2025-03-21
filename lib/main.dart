import 'package:flutter/material.dart';
import 'package:myproject/screens/home.dart';
import 'package:myproject/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:myproject/providers/transaction_provider.dart';

/*void main() {
  
  /* 
  const app = MaterialApp(
    title: "My Title",
    home: Text("Hello World eiei XD"),
  );
  runApp(app);
  */

  /*
  runApp(const MaterialApp(
    title: "My Title",
    home: Text("Hello World eiei :)"),
  ));
  */

  runApp( MyApp());
}*/

/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: "My Title",
    home: 
    Scaffold(
      appBar: AppBar(
        title: const Text("My App eiei",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: LoginPage(),
    ),
  );
  }
}
*/

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TransactionProvider(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
