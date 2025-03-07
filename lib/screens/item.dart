import 'package:flutter/material.dart';
import 'package:myproject/models/person.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/screens/addform_item.dart';

class Item extends StatefulWidget {
  const Item({super.key});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  /*
  int quantity = 10;

  void addQuantity(){
    setState(() {
      quantity++;
    });
  }

  void removeQuantity(){
    setState(() {
      quantity=quantity<=0?0:quantity-1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$quantity",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 170, 118, 99),
              foregroundColor: Colors.white
            ),
            onPressed: addQuantity,
           child: const Text("+", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
           ),
           const SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 170, 118, 99),
              foregroundColor: Colors.white
            ),
            onPressed: removeQuantity,
           child: const Text("-", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
           )
        ],
      ),
    );
  }
  */

  /*
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context,index){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: data[index].job.color
          ),
          margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
          padding: const EdgeInsets.all(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name : ${data[index].name} ${data[index].lastName}",style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  Text("Country : ${data[index].country}", style: const TextStyle(fontSize: 20),),
                  Text("Job : ${data[index].job.title}", style: const TextStyle(fontSize: 20),),
                ],
              ),
              Image.asset(
                data[index].job.image,
                width: 80,
                height: 80
              )
          ]),
        );
      },
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "แบบฟอร์มแสดงข้อมูล",
            style: GoogleFonts.kanit(
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 190, 131, 110),
          centerTitle: true,
          toolbarHeight: 60,
        ),

        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: data[index].job.color,
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name : ${data[index].name} ${data[index].lastName}",
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "Age : ${data[index].age}",
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(fontSize: 20),
                                ),
                              ),
                              Text(
                                "Country : ${data[index].country}",
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(fontSize: 20),
                                ),
                              ),
                              Text(
                                "Job : ${data[index].job.title}",
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          Image.asset(
                            data[index].job.image,
                            width: 80,
                            height: 80,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 100,
                    child: IconButton(
                      icon: const Icon(Icons.add, size: 50, color: Colors.green),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (ctx) => const AddForm()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
