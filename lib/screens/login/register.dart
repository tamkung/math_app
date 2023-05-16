import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_app/config/constant.dart';
import 'package:mysql1/mysql1.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final yearController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  List<String> _province = [
    'ช่างอุตสาหกรรม',
    'เคหะบริบาร',
  ];
  String? _selectedProvince;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
              buildTextField(
                  "ชื่อ", Icon(Icons.person), firstnameController, false),
              heightBox(size.height * 0.02),
              buildTextField(
                  "นามสกุล", Icon(Icons.person), lastnameController, false),
              heightBox(size.height * 0.02),
              buildTextField(
                  "ชั้นปี", Icon(Icons.school), yearController, false),
              heightBox(size.height * 0.02),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.school, color: Color(0XFF898989)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    width: size.width * 0.8,
                    child: DropdownButton(
                      iconEnabledColor: Colors.white,
                      hint: const Text(
                        'กลุ่มผู้เรียน',
                        style: TextStyle(color: Colors.grey),
                      ),
                      value: _selectedProvince,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedProvince = newValue.toString();
                        });
                      },
                      items: _province.map((type) {
                        return DropdownMenuItem(
                          child: new Text(type),
                          value: type,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              heightBox(size.height * 0.02),
              buildTextField("เบอร์โทรศัพท์", Icon(Icons.phone),
                  phoneNumberController, false),
              heightBox(size.height * 0.02),
              buildTextField(
                  "อีเมล", Icon(Icons.email), emailController, false),
              heightBox(size.height * 0.02),
              buildTextField(
                  "รหัสผ่าน", Icon(Icons.lock), passwordController, true),
              heightBox(size.height * 0.02),
              buildTextField("ยืนยันรหัสผ่าน", Icon(Icons.lock),
                  confirmPasswordController, true),
              heightBox(size.height * 0.02),
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
              heightBox(size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('มีบัญชีผู้ใช้แล้ว?'),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
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

Widget buildTextField(String labelText, Icon icon,
    TextEditingController controller, bool obscureText) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: labelText,
          icon: icon,
        ),
        obscureText: obscureText),
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
