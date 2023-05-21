import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get_storage/get_storage.dart';
import 'package:math_app/config/constant.dart';
import 'package:http/http.dart' as http;
import 'package:math_app/screens/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    GetStorage box = GetStorage();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg-home.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              heightBox(size.height * 0.1),
              Image.asset(
                'assets/images/login-logo.png',
                width: size.width * 0.5,
              ),
              const Text(
                'เข้าสู่ระบบ',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              heightBox(size.height * 0.02),
              txtField('อีเมล', emailController, Icons.mail, false),
              heightBox(size.height * 0.01),
              txtField('รหัสผ่าน', passwordController, Icons.lock, true),
              Container(
                padding: const EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, 'ForgotPassword'),
                  child: const Text(
                    'ลืมรหัสผ่าน',
                    style: TextStyle(
                      color: pColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
                  if (emailController.text != '' &&
                      passwordController.text != '') {
                    var url = Uri.parse('${API_URL}auth/signin');
                    try {
                      var response = await http.post(url, body: {
                        'email': emailController.text,
                        'password': passwordController.text,
                      });
                      if (response.statusCode == 200) {
                        var result = jsonDecode(response.body);
                        if (result['status'] == 'OK') {
                          box.write('isLogin', true);
                          box.write('u_id', result['u_id']);
                          box.write('email', result['email']);
                          box.write('firstname', result['firstname']);
                          box.write('lastname', result['lastname']);
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('เข้าสู่ระบบสำเร็จ'),
                              content: Text(result['message']),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const HomeScreen()),
                                        ModalRoute.withName('Home'));
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
                        print(response.body);

                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('เกิดข้อผิดพลาด'),
                            content: Text(response.body),
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
                    'เข้าสู่ระบบ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              heightBox(size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('หากยังไม่มีบัญชี'),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, 'Register'),
                    child: const Text(
                      'สมัครสมาชิก',
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
