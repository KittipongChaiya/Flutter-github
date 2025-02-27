import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/models/person.dart';
import 'package:myproject/screens/item.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {

  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _lastName = "";
  int _age = 20;
  Job _job = Job.Flutter;
  String _country = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: "My Title",
    home: Scaffold(
      appBar: AppBar(
        title: Text("แบบฟอร์มบันทึกข้อมูล",style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),


      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 20,
                decoration: InputDecoration(
                  label: Text("ชื่อ",style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณากรอกชื่อ";
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),


              TextFormField(
                maxLength: 20,
                decoration: InputDecoration(
                  label: Text("นามสกุล",style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณากรอกนามสกุล";
                  }
                  return null;
                },
                onSaved: (value) {
                  _lastName = value!;
                },
              ),


              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text("อายุ",style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณากรอกอายุ";
                  }
                  return null;
                },
                onSaved: (value) {
                  _age = int.parse(value.toString());
                },
              ),


              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  label: Text("ประเทศ",style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณากรอกประเทศ";
                  }
                  return null;
                },
                onSaved: (value) {
                   _country = value!;
                },
              ),


              SizedBox(height: 20,),
              DropdownButtonFormField(
                value: _job,
                decoration: InputDecoration(
                  label: Text("อาชีพ",style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                ),
                items: Job.values.map((key){
                  return DropdownMenuItem(
                    value: key,
                    child: Text(key.title)
                  );
                }).toList(), 
                onChanged: (value){
                  setState(() {
                    _job = value!;
                  });
                }),


              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              FilledButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    data.add(
                      Person(
                      name : _name,
                      lastName : _lastName,
                      country : _country,
                      age : _age,
                      job : _job
                      )
                    );
                    print(data.length);
                    _formKey.currentState!.reset();
                    Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (ctx) =>  Item()));
                  }
                }, 
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.blue
                ),
                child: Text("บันทึก",style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
              ),

              
              SizedBox(width: 20,),
              FilledButton(
                onPressed: (){
                  _formKey.currentState!.reset();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.green
                ),
                child: Text("รีเซ็ต",style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
              ),

              SizedBox(width: 20,),
              FilledButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (ctx) =>  Item()));
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                child: Text("ย้อนกลับ",style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
              ),
              ])
            ],
          ),
        )
      ),
    ),
  );
  }
}