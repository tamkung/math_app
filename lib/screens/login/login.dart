import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_app/config/constant.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
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
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
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
                          child: Icon(
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
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'ลืมรหัสผ่าน',
                  style: TextStyle(
                    color: pColor,
                  ),
                ),
              ),
            ),
            SizedBox(
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
              onPressed: () {
                Navigator.pushNamed(context, 'Home');
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
