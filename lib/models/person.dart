import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum Job { 
  Flutter(title: "Flutter", image: "assets/images/pic1.png", color: Colors.blue), 
  Backend(title: "Backend", image: "assets/images/pic2.png", color: Colors.green), 
  Designer(title: "Designer", image: "assets/images/pic3.png", color: Colors.purple), 
  Frontend(title: "Frontend", image: "assets/images/pic4.png", color: Colors.red),;

  const Job({required this.title, required this.image, required this.color});
  final String title;
  final String image;
  final Color color;
}

class Person {
  String name;
  String lastName;
  String country;
  int age;
  Job job;
  Person({
    required this.name,
    required this.lastName,
    required this.country,
    required this.job,
    required this.age
  });
}

List<Person> data = [
  Person(
    name: "tom",
    lastName: "babo",
    country: "United States",
    job: Job.Flutter,
    age: 20
  ),
  Person(
    name: "tim",
    lastName: "baba",
    country: "Turkey",
    job: Job.Frontend,
    age: 30
  ),
  Person(
    name: "tow",
    lastName: "bebe",
    country: "Germany",
    job: Job.Backend,
    age: 40
  ),
  Person(
    name: "tam", 
    lastName: "bgbg", 
    country: "Italy", 
    job: Job.Designer,
    age: 50
    )
];
