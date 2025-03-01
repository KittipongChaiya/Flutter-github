import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/screens/login.dart';
import 'package:postgres/postgres.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Function สำหรับเชื่อมต่อและบันทึกข้อมูลลง PostgreSQL
  Future<void> _registerUser() async {
    try {
      // เชื่อมต่อฐานข้อมูล PostgreSQL
      final connection = await Connection.open(
        Endpoint(
          host: 'localhost',
          port: 5432,
          database: 'db_login',
          username: 'postgres',
          password: '1234',
        ),
        settings: const ConnectionSettings(sslMode: SslMode.disable),
      );

      // คำสั่ง SQL สำหรับบันทึกข้อมูลผู้ใช้
      await connection.execute(
        'INSERT INTO users (username, email, password) VALUES (@username, @email, @password)',
        parameters: {
          'username': _usernameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      // ปิดการเชื่อมต่อ
      await connection.close();

      // แสดง Snackbar เมื่อสมัครสมาชิกสำเร็จ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('สมัครสมาชิกสำเร็จ', style: GoogleFonts.kanit())),
      );

      // นำทางไปหน้า Login
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (ctx) => LoginPage())
      );

    } catch (e) {
      // จัดการข้อผิดพลาดในการเชื่อมต่อหรือบันทึกข้อมูล
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
                'assets/images/pic2.png',
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
              ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (ctx) =>  LoginPage()));
                },
                child: Text("เข้าสู่ระบบ",style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Color.fromARGB(255, 116, 142, 190))),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}