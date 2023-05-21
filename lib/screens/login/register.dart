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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 60,
            bottom: 10,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: pColor,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          bottom: 20,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'สมัครสมาชิก',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildTextField("ชื่อ", Icons.person, firstnameController, false),
              buildTextField(
                  "นามสกุล", Icons.person, lastnameController, false),
              buildTextField("ชั้นปี", Icons.school, yearController, false),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40))),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: pColor,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: const Icon(
                            Icons.school,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                  ),
                  Positioned(
                    top: 0,
                    left: 70,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'กลุ่มผู้เรียน',
                        style: TextStyle(
                            fontSize: 14,
                            backgroundColor: Colors.white,
                            color: Colors.grey[700]),
                      ),
                    ),
                  ),
                ],
              ),
              buildTextField(
                  "เบอร์โทรศัพท์", Icons.phone, phoneNumberController, false),
              buildTextField("อีเมล", Icons.email, emailController, false),
              buildTextField("รหัสผ่าน", Icons.lock, passwordController, true),
              buildTextField("ยืนยันรหัสผ่าน", Icons.lock,
                  confirmPasswordController, true),
              heightBox(size.height * 0.02),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
                child: Text(
                  'สมัครใช้งาน',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
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

Widget txtField(String labelText, Icon icon, TextEditingController controller,
    bool obscureText) {
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

Widget buildTextField(text, icon, controller, obscureText) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(40))),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
            icon: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: pColor,
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: 70,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14,
                backgroundColor: Colors.white,
                color: Colors.grey[700]),
          ),
        ),
      ),
    ],
  );
}

Widget buildSelect(text, icon, controller, obscureText) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(40))),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
            icon: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: pColor,
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: 70,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14,
                backgroundColor: Colors.white,
                color: Colors.grey[700]),
          ),
        ),
      ),
    ],
  );
}
