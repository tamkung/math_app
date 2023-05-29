import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:math_app/widget/navdrawer.dart';
import 'package:math_app/config/constant.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  final old_password = TextEditingController();
  final new_password = TextEditingController();
  final conf_new_password = TextEditingController();

  dynamic email, user_id;
  GetStorage box = GetStorage();

  Future<void> getUser() async {
    email = box.read('email');
    user_id = box.read('u_id');
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.10),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                'เปลี่ยนรหัสผ่าน',
                style: TextStyle(fontSize: 36),
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
          backgroundColor: Colors.white,
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
            border: Border(),
            image: DecorationImage(
              image: AssetImage("assets/images/bg-change-pass.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  width: size.width * 0.87,
                  height: size.height * 0.6,
                  child: Container(
                    child: Column(
                      children: [
                        heightBox(size.height * 0.13),
                        txtField(
                            'รหัสผ่านเก่า', Icons.lock_outline, old_password),
                        txtField(
                            'รหัสผ่านใหม่', Icons.lock_outline, new_password),
                        txtField('รหัสผ่านใหม่', Icons.lock_outline,
                            conf_new_password),
                        heightBox(size.height * 0.05),
                        SizedBox(
                          height: size.height * 0.06,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 10)),
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
                              if (old_password.text.isNotEmpty &&
                                  new_password.text.isNotEmpty &&
                                  conf_new_password.text.isNotEmpty) {
                                if (new_password.text ==
                                    conf_new_password.text) {
                                  addQuizResult(
                                      old_password.text, new_password.text);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('แจ้งเตือน'),
                                      content: const Text(
                                          'รหัสผ่านใหม่ไม่ตรงกัน กรุณากรอกใหม่อีกครั้ง'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('ตกลง'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('แจ้งเตือน'),
                                    content:
                                        const Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('ตกลง'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'บันทึก',
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
              ),
              Positioned(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: size.width * 0.5,
                  height: size.height * 0.25,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/change-pass.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addQuizResult(old_pass, new_pass) async {
    var url = Uri.parse('${API_URL}auth/changepass');
    final response = await http.post(url,
        body: jsonEncode({
          "u_id": user_id,
          "email": email,
          "old_pass": old_pass,
          "new_pass": new_pass,
        }),
        headers: {"Content-type": "application/json"});
    final data = await json.decode(utf8.decode(response.bodyBytes));
    print(data);
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      print(data);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('แจ้งเตือน'),
          content: const Text('เปลี่ยนรหัสผ่านสำเร็จ'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('ตกลง'),
            ),
          ],
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('แจ้งเตือน'),
          content: const Text('รหัสผ่านเก่าไม่ถูกต้อง'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ตกลง'),
            ),
          ],
        ),
      );
    }
  }

  Widget txtField(text, icon, controller) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2),
            borderRadius: const BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            obscureText: true,
            controller: controller,
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
}
