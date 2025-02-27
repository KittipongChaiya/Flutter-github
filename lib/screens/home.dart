import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  /*
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.blue,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        padding: const EdgeInsets.fromLTRB(10,20,30,40),
        child: const Text("Hello World :D !!!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30
          ),
        ),
      ),
    );
  }
  */

  /*
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.blue,
        padding: const EdgeInsets.fromLTRB(10,20,30,40),
        child: const Text("Hello World :D !!!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30
          ),
        ),
        ),
        Container(
          color: Colors.blue,
        padding: const EdgeInsets.fromLTRB(10,20,30,40),
        child: const Text("Hello World :D !!!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30
          ),
        ),
        ),
        Container(
          color: Colors.blue,
        padding: const EdgeInsets.fromLTRB(10,20,30,40),
        child: const Text("Hello World :D !!!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30
          ),
        ),
        )
      ],
    );
  }
}
*/

  /*
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.blue,
        padding: const EdgeInsets.fromLTRB(10,20,30,40),
        child: const Text("Hello",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30
          ),
        ),
        ),
        Container(
          color: Colors.blue,
        padding: const EdgeInsets.fromLTRB(10,20,30,40),
        child: const Text("Hello",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30
          ),
        ),
        ),
        Container(
          color: Colors.blue,
        padding: const EdgeInsets.fromLTRB(10,20,30,40),
        child: const Text("Hello",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30
          ),
        ),
        )
      ],
    );
  }
}
*/

  /*
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.network(
          "https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png",
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 30,),
        Image.asset(
          "assets/images/pic1.png",
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 30,),
        Image.asset(
          "assets/images/pic2.png",
          width: 200,
          height: 200,
        )
      ],
    );
  }
}
*/

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              print("TextButton Click");
            },
            child: const Text(
              "Click",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              print("FilledButton Click");
            },
            child: const Text(
              "Click",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 2, color: Colors.red),
            ),
            onPressed: () {
              print("OutlinedButton Click");
            },
            child: const Text(
              "Click",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          IconButton(
            onPressed: () {
              print("IconButton Click");
            },
            icon: const Icon(Icons.add),
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {
              print("FloatingActionButton Click");
            },
            child: const Icon(Icons.add),
          ),
          SizedBox(height: 20),
          FloatingActionButton.extended(
            onPressed: () {
              print("FloatingActionButton Click");
            },
            label: const Text("Click"),
            icon: const Icon(Icons.add),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              print("ElevatedButton Click");
            },
            child: const Text(
              "Click",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
