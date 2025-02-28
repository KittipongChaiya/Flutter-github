import 'package:flutter/material.dart';
import 'package:myproject/screens/item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/screens/register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เข้าสู่ระบบ", style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),),
        backgroundColor: const Color.fromARGB(255, 190, 136, 116),
        centerTitle: true,
        toolbarHeight: 60,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Image.asset(
                  'assets/images/pic1.png',
                  width: 200,
                  height: 200
                ),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'อีเมลล์',
                    labelStyle: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกอีเมลล์';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!,
                ),

                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'รหัสผ่าน',
                    labelStyle: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกรหัสผ่าน';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                ),

                SizedBox(height: 3),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                       
                      // กำหนดอีเมลและรหัสผ่านที่ถูกต้อง
                      const validEmail = 'aaa@gmail.com';
                      const validPassword = '123123123';

                      if (_email != validEmail || _password != validPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'อีเมลหรือรหัสผ่านไม่ถูกต้อง', 
                              style: GoogleFonts.kanit()
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // หากผ่านการตรวจสอบ จึงไปหน้า Item
                      Navigator.push(context, MaterialPageRoute(
                        builder: (ctx) => Item()
                      ));
                    }
                  },
                  child: Text('เข้าสู่ระบบ', style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 190, 136, 116))),),
                ),
                SizedBox(width: 20,),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (ctx) =>  RegisterPage()));
                },
                child: Text("สมัครสมาชิก",style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Color.fromARGB(255, 116, 142, 190))),),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}