import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_app/config/constant.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final List<String> _user_year =
      List.generate(55, (index) => (index + 46).toString());
  String? _selectedUserYear;
  final List<String> _user_type = [
    'L1',
    'L2',
    'L3',
    'L4',
  ];
  String? _selectedUserType;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.10),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              border: Border(),
              image: DecorationImage(
                image: AssetImage("assets/images/bg-change-pass.png"),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'สมัครสมาชิก',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          automaticallyImplyLeading: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                splashRadius: 20,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: pColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            border: Border(),
            image: DecorationImage(
              image: AssetImage("assets/images/bg-change-pass.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: Column(
              children: [
                buildTextField(
                    "ชื่อ", Icons.person, firstnameController, false),
                buildTextField(
                    "นามสกุล", Icons.person, lastnameController, false),
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
                              menuMaxHeight: size.height * 0.4,
                              iconEnabledColor: Colors.grey[800],
                              hint: SizedBox(
                                width: size.width * 0.3,
                                child: const Text(
                                  'รุ่นที่',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              value: _selectedUserYear,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedUserYear = newValue.toString();
                                });
                              },
                              items: _user_year.map((type) {
                                return DropdownMenuItem(
                                  child: new Text('รุ่นที่ : $type'),
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
                          'รุ่นที่',
                          style: TextStyle(
                              fontSize: 14,
                              backgroundColor: Colors.white,
                              color: Colors.grey[700]),
                        ),
                      ),
                    ),
                  ],
                ),
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
                              iconEnabledColor: Colors.grey[800],
                              hint: SizedBox(
                                width: size.width * 0.3,
                                child: const Text(
                                  'กลุ่มผู้เรียน',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              value: _selectedUserType,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedUserType = newValue.toString();
                                });
                              },
                              items: _user_type.map((type) {
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
                buildTextField(
                    "รหัสผ่าน", Icons.lock, passwordController, true),
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
                    final phoneNumber = phoneNumberController.text;
                    final email = emailController.text;
                    final password = passwordController.text;
                    final confirmPassword = confirmPasswordController.text;
                    if (firstname.isEmpty ||
                        lastName.isEmpty ||
                        phoneNumber.isEmpty ||
                        email.isEmpty ||
                        password.isEmpty ||
                        confirmPassword.isEmpty ||
                        _selectedUserType == null ||
                        _selectedUserYear == null) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('แจ้งเตือน'),
                          content: const Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('ตกลง'),
                            ),
                          ],
                        ),
                      );
                      return;
                    } else if (!email.contains('@')) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('อีเมลไม่ถูกต้อง'),
                          content: const Text('กรุณากรอกอีเมลให้ถูกต้อง'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('ตกลง'),
                            ),
                          ],
                        ),
                      );
                    } else if (password.length < 8 &&
                        confirmPassword.length < 8) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('รหัสผ่านไม่ถูกต้อง'),
                          content: const Text(
                              'กรุณากรอกรหัสผ่านให้มีความยาวมากกว่า 8 ตัวอักษร'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('ตกลง'),
                            ),
                          ],
                        ),
                      );
                    } else if (password != confirmPassword) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('รหัสผ่านไม่ตรงกัน'),
                          content: const Text('กรุณากรอกรหัสผ่านให้ตรงกัน'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('ตกลง'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      var url = Uri.parse('${API_URL}auth/signup');
                      try {
                        var response = await http.post(url, body: {
                          'fname': firstname,
                          'lname': lastName,
                          'year': _selectedUserYear,
                          'user_type': _selectedUserType,
                          'phone': phoneNumber,
                          'email': email,
                          'password': confirmPassword,
                        });
                        if (response.statusCode == 200) {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('สมัครสมาชิกสำเร็จ'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Map<String, dynamic> user =
                                        jsonDecode(response.body);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('ตกลง'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          response.body == '{"message":"Email already exists"}'
                              // ignore: use_build_context_synchronously
                              ? showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('อีเมลนี้มีผู้ใช้แล้ว'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('ตกลง'),
                                      ),
                                    ],
                                  ),
                                )
                              : print(response.body);
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                    //Navigator.pushNamed(context, 'Home');
                  },
                  child: const Text(
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
      ),
    );
  }
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
