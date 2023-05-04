import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_app/config/constant.dart';
import 'package:mysql1/mysql1.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firstnameController = TextEditingController();
    final lastnameController = TextEditingController();
    final yearController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: pColor,
        centerTitle: true,
        title: Text("สมัครสมาชิก"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              buildTextField("ชื่อ", Icon(Icons.person), firstnameController),
              SizedBox(
                height: 10,
              ),
              buildTextField("นามสกุล", Icon(Icons.person), lastnameController),
              SizedBox(
                height: 10,
              ),
              buildTextField("ชั้นปี", Icon(Icons.school), yearController),
              SizedBox(
                height: 10,
              ),
              buildTextField(
                  "เบอร์โทรศัพท์", Icon(Icons.phone), phoneNumberController),
              SizedBox(
                height: 10,
              ),
              buildTextField("อีเมล", Icon(Icons.email), emailController),
              SizedBox(
                height: 10,
              ),
              buildTextField("รหัสผ่าน", Icon(Icons.lock), passwordController),
              SizedBox(
                height: 10,
              ),
              buildTextField("ยืนยันรหัสผ่าน", Icon(Icons.lock),
                  confirmPasswordController),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => pColor,
                  ),
                ),
                onPressed: () async {
                  final firstname = firstnameController.text;
                  final lastName = lastnameController.text;
                  final year = yearController.text;
                  final phoneNumber = phoneNumberController.text;
                  final email = emailController.text;
                  final password = passwordController.text;
                  final confirmPassword = confirmPasswordController.text;
                  print(
                      '$firstname $lastName $year $phoneNumber $email $password $confirmPassword');
                  if (password == confirmPassword) {
                    var url = Uri.parse('${API_URL}auth/signup');
                    try {
                      var response = await http.post(url, body: {
                        'fname': firstname,
                        'lname': lastName,
                        'year': year,
                        'phone': phoneNumber,
                        'email': email,
                        'password': confirmPassword,
                      });
                      if (response.statusCode == 200) {
                        Map<String, dynamic> user = jsonDecode(response.body);
                        print(user['token']);
                        Navigator.pushNamed(context, 'Login');
                      } else {
                        print(response.body);
                      }
                    } catch (e) {
                      print(e);
                    }
                  } else {
                    print('password not match');
                  }
                  //Navigator.pushNamed(context, 'Home');
                },
                child: Text('สมัครใช้งาน'),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('มีบัญชีผู้ใช้แล้ว?'),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(
                        color: pColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildTextField(
    String labelText, Icon icon, TextEditingController controller) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: labelText,
        icon: icon,
      ),
    ),
  );
}

Future insertData(
  String firstname,
  String lastname,
  String year,
  String email,
  String password,
) async {
  var timestamp = DateTime.now().millisecondsSinceEpoch;
  print(timestamp);

  final conn = await MySqlConnection.connect(ConnectionSettings(
    host: '18.139.38.227',
    port: 3306,
    user: 'username',
    password: 'password',
    db: 'dbphradabos',
  ));
  try {
    final result = await conn.query(
        'INSERT INTO users (first_name, last_name, email, password, user_year, role_id, date_added) '
        'VALUES (?, ?, ?, ?, ?, ?, ?)',
        [firstname, lastname, email, password, year, 2, timestamp]);
    print('Inserted ${result.affectedRows} row(s)');
  } finally {
    await conn.close();
  }
}
