import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:myproject/screens/item.dart';
import 'dart:convert';
import 'package:myproject/screens/register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://10.0.2.2:3000/api/auth/login');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      setState(() {
        _isLoading = false;
      });

      print('Login Response Status: ${response.statusCode}');
      print('Login Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        
        // บันทึก Token และ User ID
        // คุณอาจต้องสร้าง SharedPreferences เพื่อเก็บ Token
        // await saveToken(responseData['token']);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'เข้าสู่ระบบสำเร็จ', 
              style: GoogleFonts.kanit(),
            ),
            backgroundColor: Colors.green,
          ),
        );

        // นำทางไปหน้าหลัก
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => Item())
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'เข้าสู่ระบบไม่สำเร็จ: ${json.decode(response.body)['message']}', 
              style: GoogleFonts.kanit(),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'เกิดข้อผิดพลาด: $e', 
            style: GoogleFonts.kanit(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เข้าสู่ระบบ", style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),),
        backgroundColor: const Color.fromARGB(255, 190, 136, 116),
        centerTitle: true,
        toolbarHeight: 60,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/w.png',
                width: 200,
                height: 200,
              ),

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'อีเมล',
                  labelStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกอีเมล';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16.0),
              
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'รหัสผ่าน',
                  labelStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกรหัสผ่าน';
                  }
                  return null;
                },
              ),

              SizedBox(height: 24),
              
              _isLoading 
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _loginUser,
                    child: Text(
                      'เข้าสู่ระบบ',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 190, 136, 116)
                        ),
                      ),
                    ),
                  ),

              SizedBox(height: 10),
              
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (ctx) => RegisterPage())
                  );
                },
                child: Text(
                  "สมัครสมาชิก",
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 116, 142, 190)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}