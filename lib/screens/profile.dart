import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_app/widget/navdrawer.dart';
import 'package:math_app/config/constant.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: pColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.11),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                'ประวัติ',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
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
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          foregroundColor: Colors.black,
          elevation: 0,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: size.height * 1,
          width: size.width * 1,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: pColor,
            border: Border(),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
            ),
            image: DecorationImage(
              image: AssetImage("assets/images/bg-home.png"),
              fit: BoxFit.fill,
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
                    borderRadius: BorderRadius.all(Radius.circular(30)),
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
                              labelText: 'ชื่อผู้ใช้',
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
                              labelText: 'นามสกุล',
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
                              labelText: 'อีเมล',
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
                              Navigator.pushNamed(context, 'ChangePassword');
                            },
                            child: Text('เปลี่ยนรหัสผ่าน',
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
                      border: BorderDirectional(
                        top: BorderSide(width: 5.0, color: Colors.white),
                        bottom: BorderSide(width: 5.0, color: Colors.white),
                        start: BorderSide(width: 5.0, color: Colors.white),
                        end: BorderSide(width: 5.0, color: Colors.white),
                      ),
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 202, 202, 202),
                      image: DecorationImage(
                        image: AssetImage("assets/images/login-logo.png"),
                        fit: BoxFit.fill,
                      ),
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
