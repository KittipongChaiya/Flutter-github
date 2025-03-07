import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myproject/models/transactions.dart';
import 'package:myproject/screens/addform_account.dart';
import 'package:provider/provider.dart';
import 'package:myproject/providers/transaction_provider.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "หน้าบัญชี",
          style: GoogleFonts.kanit(
            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            iconSize: 30,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FormAccount()));
            },
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 190, 131, 110),
        centerTitle: true,
        toolbarHeight: 60,
      ),
      
      body: Consumer(
        builder: (context, TransactionProvider provider, Widget? child) {
          var count = provider.transaction.length;
          if (count <= 0) {
            return Center(
              child: Text("ไม่มีข้อมูล", style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black)),),
            );
          }else {
            return ListView.builder(
            itemCount: count,
            itemBuilder: (context, index){
              Transactions data = provider.transaction[index];
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Text("${data.amount}", style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 16)),),
                    ),
                  ),
                  title: Text("${data.title}", style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),),
                  subtitle: Text("${DateFormat('dd/MM/yyyy').format(data.date)}", style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 15)),),
                )
              );
            },
          );
        }
        }
      )
    );
  }
}