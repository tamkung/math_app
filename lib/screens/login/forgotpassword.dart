import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_app/config/constant.dart';
import 'package:http/http.dart' as http;
import 'package:math_app/screens/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  String? API_URL = dotenv.env['API_URL'];

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
              'ลืมรหัสผ่าน',
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
          alignment: Alignment.topCenter,
          height: size.height * 0.9,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            border: Border(),
            image: DecorationImage(
              image: AssetImage("assets/images/bg-change-pass.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              heightBox(size.height * 0.1),
              Image.asset(
                'assets/images/change-pass.png',
                width: size.width * 0.5,
              ),
              heightBox(size.height * 0.07),
              txtField('อีเมล', emailController, Icons.mail, false),
              heightBox(size.height * 0.07),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => pColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  if (emailController.text != '') {
                    var url = Uri.parse('${API_URL}auth/forgotpass');
                    try {
                      var response = await http.post(url, body: {
                        'email': emailController.text,
                      });
                      var result = jsonDecode(response.body);
                      if (response.statusCode == 200) {
                        if (result['message'] == 'Email sent successfully') {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('ส่งรหัสผ่านใหม่สำเร็จ'),
                              content: Text(
                                  'รหัสผ่านใหม่ได้ถูกส่งไปยังอีเมล ${emailController.text}'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text('ตกลง'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          print(result['message']);
                        }
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('เกิดข้อผิดพลาด'),
                            content: Text(
                                result['message'] == 'Invalid email or password'
                                    ? 'อีเมลหรือรหัสผ่านไม่ถูกต้อง'
                                    : result['message'] == 'User not found'
                                        ? 'ไม่พบผู้ใช้งาน'
                                        : result['message']),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('ปิด'),
                              ),
                            ],
                          ),
                        );
                      }
                    } catch (error) {
                      print(error);
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('เกิดข้อผิดพลาด'),
                        content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('ปิด'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'ยืนยัน',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              heightBox(size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}

Widget txtField(text, controller, icon, obscureText) {
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
