import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_app/widget/navdrawer.dart';
import 'package:math_app/config/constant.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'เปลี่ยนรหัสผ่าน',
          style: TextStyle(fontSize: 40),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Colors.black,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
          ),
        ),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
            ),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 125, 0, 0),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  width: 325,
                  height: 450,
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              labelText: 'รหัสผ่านเก่า',
                              icon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              labelText: 'รหัสผ่านใหม่',
                              icon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              labelText: 'ยืนยันรหัสผ่านใหม่',
                              icon: Icon(Icons.email),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 45,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                (states) => pColor,
                              ),
                            ),
                            onPressed: () {
                              //Navigator.pushNamed(context, 'changepassword');
                            },
                            child: Text('บันทึก',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    width: 175,
                    height: 175,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 167, 13, 13),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
