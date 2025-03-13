import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:myproject/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');

  if (token == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'ไม่พบข้อมูลการเข้าสู่ระบบ',
          style: GoogleFonts.kanit(),
        ),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  final response = await http.get(
    Uri.parse('http://10.0.2.2:3000/api/auth/user'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final userData = jsonDecode(response.body);
    setState(() {
      _nameController.text = userData['username'] ?? '';
      _emailController.text = userData['email'] ?? '';
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'เกิดข้อผิดพลาดในการดึงข้อมูลผู้ใช้',
          style: GoogleFonts.kanit(),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}

  Future<void> _updateUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');

  if (token == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'ไม่พบข้อมูลการเข้าสู่ระบบ',
          style: GoogleFonts.kanit(),
        ),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  final Map<String, dynamic> requestBody = {
    'username': _nameController.text,
    'email': _emailController.text,
  };

  if (_passwordController.text.isNotEmpty) {
    requestBody['password'] = _passwordController.text;
  }

  final response = await http.put(
    Uri.parse('http://10.0.2.2:3000/api/auth/user'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'อัปเดตข้อมูลสำเร็จ',
          style: GoogleFonts.kanit(),
        ),
        backgroundColor: Colors.green,
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'เกิดข้อผิดพลาดในการอัปเดตข้อมูล',
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
        title: Text('จัดการโปรไฟล์'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'ชื่อ',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกชื่อ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'อีเมล',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกอีเมล';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'รหัสผ่าน',
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _updateUserData();
                      Navigator.push(
                        context, MaterialPageRoute(builder: (ctx) => Home())
                  );
                    }
                  },
                  child: Text('บันทึกการเปลี่ยนแปลง'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}