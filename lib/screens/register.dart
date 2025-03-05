import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/screens/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isEmailAvailable = true;
  Timer? _debounce;

  bool _isValidEmail(String email) {
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$'
  );
  return emailRegex.hasMatch(email);
}

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onEmailChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_isValidEmail(value)) {
        _checkEmailAvailability();
      }
    });
  }

   Future<void> _checkEmailAvailability() async {
    if (_emailController.text.isEmpty) {
      return;
    }

     if (!_isValidEmail(_emailController.text)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'รูปแบบอีเมลไม่ถูกต้อง',
          style: GoogleFonts.kanit(),
        ),
        backgroundColor: Colors.orange,
      ),
    );
    return;
  }

    final url = Uri.parse('http://10.0.2.2:3000/api/auth/check-email');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': _emailController.text,
        }),
      );

      setState(() {
        _isEmailAvailable = response.statusCode == 200;
      });

      if (_isEmailAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'อีเมลนี้สามารถใช้งานได้',
            style: GoogleFonts.kanit(),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'อีเมลนี้มีอยู่ในระบบแล้ว',
            style: GoogleFonts.kanit(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    print('เกิดข้อผิดพลาดในการตรวจสอบอีเมล: $e');
  }
}

  // Function สำหรับเชื่อมต่อและบันทึกข้อมูลลง PostgreSQL
  Future<void> _registerUser() async {
  final url = Uri.parse('http://10.0.2.2:3000/api/auth/register');
  
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': _usernameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('สมัครสมาชิกสำเร็จ', style: GoogleFonts.kanit()),
        backgroundColor: Colors.green,
        ),
      );
      
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (ctx) => LoginPage())
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('การสมัครล้มเหลว', style: GoogleFonts.kanit()),
        backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('เกิดข้อผิดพลาด: $e', style: GoogleFonts.kanit())),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สมัครสมาชิก", style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),),
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
                height: 200
              ),

              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'ชื่อผู้ใช้',
                  labelStyle: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกชื่อผู้ใช้';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16.0),

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'อีเมล',
                  labelStyle: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: _checkEmailAvailability,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _isEmailAvailable = true;
                  });
                  _onEmailChanged(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกอีเมล';
                  }
                  if (!_isEmailAvailable) {
                    return 'อีเมลนี้มีอยู่ในระบบแล้ว';
                  }
                  if (!_isValidEmail(value)) {
                    return 'รูปแบบอีเมลไม่ถูกต้อง';
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
                  labelStyle: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกรหัสผ่าน';
                  }
                  return null;
                },
              ),

              SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // เรียกใช้ฟังก์ชันบันทึกข้อมูลผู้ใช้
                    _registerUser();
                  }
                },
                child: Text('สมัครสมาชิก',style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Color.fromARGB(255, 190, 136, 116))),),
              ),

              SizedBox(height: 10),
              
              /*ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (ctx) =>  LoginPage()));
                },
                child: Text("เข้าสู่ระบบ",style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Color.fromARGB(255, 116, 142, 190))),),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}