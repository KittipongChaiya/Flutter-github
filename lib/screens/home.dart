import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/screens/item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _username = '';
  String _email = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token'); // ดึง token จาก local storage

    if (token == null) {
      throw Exception('ไม่พบ Token');
    }

    final url = Uri.parse('http://10.0.2.2:3000/api/auth/user');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // ใช้ token จริง
      },
    ).timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      setState(() {
        _username = userData['username'] ?? 'ไม่พบข้อมูล';
        _email = userData['email'] ?? 'ไม่พบข้อมูล';
        _isLoading = false;
      });
    } else {
      throw Exception('ไม่สามารถดึงข้อมูลผู้ใช้ได้');
    }
  } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'เกิดข้อผิดพลาดในการดึงข้อมูลผู้ใช้: ${e.toString()}',
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
        title: Text("หน้าหลัก", style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),),
        backgroundColor: const Color.fromARGB(255, 190, 136, 116),
        centerTitle: true,
        toolbarHeight: 60,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.brown),
              accountName: Text('$_username'),
              accountEmail: Text('$_email'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'JD',
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text('Items'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Item()));
              },
            ),
          ],
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 100.0,
              child: 
                Image.asset(
                  'assets/images/w.png',
                  width: 200,
                  height: 200
                ),
              ),

            const SizedBox(height: 40),

            Text('ยินดีต้อนรับ', style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),),

              SizedBox(height: 10),

                Text(
                  'ชื่อผู้ใช้: $_username',
                  style: GoogleFonts.kanit(
                    fontSize: 20,
                    color: _username.isEmpty ? Colors.grey : Colors.black,
                  ),
                ),

              SizedBox(height: 10),

                Text(
                  'อีเมล: $_email',
                  style: GoogleFonts.kanit(
                    fontSize: 18,
                    color: _email.isEmpty ? Colors.grey : Colors.black,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}