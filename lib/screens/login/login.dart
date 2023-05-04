import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get_storage/get_storage.dart';
import 'package:math_app/config/constant.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    GetStorage box = GetStorage();
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'เข้าสู่ระบบ',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            //-------------------------TextField---------------------
            Stack(
              children: [
                Container(
                  height: 80,
                  width: 200,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: 'อีเมล',
                        icon: Icon(
                          Icons.email,
                          color: tColor,
                        ),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 60,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'อีเมล',
                      style: TextStyle(
                          fontSize: 14,
                          backgroundColor: Colors.white,
                          color: Colors.grey[700]),
                    ),
                  ),
                ),
              ],
            ),

            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(width: 2),
            //       borderRadius: BorderRadius.all(Radius.circular(25))),
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   child: TextFormField(
            //     decoration: InputDecoration(
            //         hintText: 'อีเมล',
            //         icon: Icon(
            //           Icons.email,
            //           color: tColor,
            //         ),
            //         border: OutlineInputBorder(borderSide: BorderSide.none)),
            //   ),
            // ),

            //-------------------------TextField---------------------

            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(width: 2),
            //       borderRadius: BorderRadius.all(Radius.circular(25))),
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   child: TextFormField(
            //     decoration: InputDecoration(
            //         hintText: 'รหัสผ่าน',
            //         icon: Icon(
            //           Icons.lock,
            //           color: tColor,
            //         ),
            //         border: OutlineInputBorder(borderSide: BorderSide.none)),
            //   ),
            // ),
            const SizedBox(
              height: 5,
            ),
            //-----------------------test--------
            Stack(
              children: [
                Container(
                  height: 80,
                  width: 200,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: 'รหัสผ่าน',
                        icon: Container(
                          // : ShapeDecoration(shape: CircleBorder()),
                          // decoration: BoxDecoration(
                          //     border: Border.all(width: 2),
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(25))),
                          padding: EdgeInsets.all(10),
                          color: pColor,
                          child: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 60,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'รหัสผ่าน',
                      style: TextStyle(
                          fontSize: 14,
                          backgroundColor: Colors.white,
                          color: Colors.grey[700]),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              padding: const EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
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
                //Navigator.pushNamed(context, 'Home');
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
                                  Navigator.pushNamed(context, 'Home');
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
                }
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'เข้าสู่ระบบ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('หากยังไม่มีบัญชี'),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'Register'),
                  child: Text(
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
    );
  }
}
