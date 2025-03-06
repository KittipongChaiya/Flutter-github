import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/models/transaction.dart';
import 'package:myproject/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class FormAccount extends StatefulWidget {
  const FormAccount({super.key});

  @override
  _FormAccountState createState() => _FormAccountState();
}

class _FormAccountState extends State<FormAccount> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "แบบฟอร์มบันทึกข้อมูล", 
          style: GoogleFonts.kanit(
            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
          )
        ),
        backgroundColor: const Color.fromARGB(255, 190, 136, 116),
        centerTitle: true,
        toolbarHeight: 60,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 20,
                autofocus: true,
                controller: _titleController,
                decoration: InputDecoration(
                  label: Text(
                    "ชื่อ", 
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                    )
                  ),             
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณากรอกชื่อ";
                  }
                  return null;
                },
              ),
              TextFormField(
                maxLength: 20,
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text(
                    "จำนวนเงิน", 
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                    )
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณากรอกจำนวนเงิน";
                  }
                  if (double.tryParse(value) == null) {
                    return "กรุณากรอกจำนวนเงินให้ถูกต้อง";
                  }
                  if (double.parse(value)<=0) {
                    return "กรุณากรอกจำนวนเงินมากกว่า 0";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var title = _titleController.text;
                    var amount = _amountController.text;

                    //เตรียมข้อมูลให้ส่งไป Provider
                    Transaction statement = Transaction(title: title, amount: double.parse(amount), date: DateTime.now());

                    //เรียก Provider
                    var provider = Provider.of<TransactionProvider>(context, listen: false);
                    provider.addTransaction(statement);
                  
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "บันทึก", 
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                  )
                )
              )
            ],
          ),
        ),
      )
    );
  }
}
