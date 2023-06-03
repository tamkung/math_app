import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get_storage/get_storage.dart';
import 'package:math_app/widget/navdrawer.dart';
import 'package:math_app/config/constant.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GetStorage box = GetStorage();
  dynamic firstname, lastname, email;

  Future<void> getUser() async {
    firstname = box.read('firstname');
    lastname = box.read('lastname');
    email = box.read('email');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: pColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.12),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                'ประวัติ',
                style: TextStyle(fontSize: 38),
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
        //physics: const NeverScrollableScrollPhysics(),
        child: Container(
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
                padding: const EdgeInsets.fromLTRB(0, 125, 0, 25),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  width: size.width * 0.87,
                  height: size.height * 0.6,
                  child: Column(
                    children: [
                      heightBox(size.height * 0.11),
                      txtField(
                          'ชื่อผู้ใช้', firstname, Icons.person_2_outlined),
                      heightBox(size.height * 0.01),
                      txtField('นามสกุล', lastname, Icons.person_2_outlined),
                      heightBox(size.height * 0.01),
                      txtField('อีเมล', email, Icons.email),
                      heightBox(size.height * 0.03),
                      SizedBox(
                        height: size.height * 0.06,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => pColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, 'ChangePassword');
                          },
                          child: const Text(
                            'เปลี่ยนรหัสผ่าน',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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

Widget txtField(text, value, icon) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(40))),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          readOnly: true,
          showCursor: false,
          enableInteractiveSelection: false,
          initialValue: value,
          decoration: InputDecoration(
            //hintText: text,
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
