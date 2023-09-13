import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:math_app/screens/login/login.dart';

import '../config/constant.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  GetStorage box = GetStorage();
  bool checkBox = false;

  final String policy = r"""
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="utf-8">
      <title>Privacy Policy</title>
    </head>
    <body>
      <h2>นโยบายความเป็นส่วนตัว</h2>

      <h3>อัปเดตล่าสุด: 13 กันยายน 2566</h3>

      <p>ขอบคุณที่ใช้บริการแอปฯ Math Phradabos เราให้ความสำคัญกับความเป็นส่วนตัวของคุณและต้องการให้คุณรู้ว่าเราเก็บและใช้ข้อมูลของคุณอย่างไร โปรดอ่านนโยบายความเป็นส่วนตัวนี้อย่างรอบคอบ</p>

      <h3>ข้อมูลที่เราเก็บ</h3>

      <p>เราอาจเก็บข้อมูลส่วนบุคคลที่คุณให้มาหรือที่เราเก็บผ่านการใช้งานของคุณในแอป ซึ่งอาจรวมถึง:</p>
      <ul>
        <li>ข้อมูลประจำตัว เช่น ชื่อ, ที่อยู่อีเมล, และข้อมูลติดต่ออื่น ๆ </li>
        <li>ข้อมูลการเรียนรู้ เช่น คำตอบที่คุณให้ในแบบทดสอบหรือคำถามที่คุณร้องขอให้เราตอบ</li>
        <li>ข้อมูลการใช้งาน เช่น บันทึกการใช้งานแอปและข้อมูลเชิงพฤติกรรม</li>
        <li>ข้อมูลอุปกรณ์ เช่น ประเภทของอุปกรณ์, ระบบปฏิบัติการ</li>
      </ul>

      <h3>วัตถุประสงค์ในการใช้ข้อมูล</h3>

      <p>เราใช้ข้อมูลของคุณเพื่อวัตถุประสงค์ต่อไปนี้:</p>

      <ul>
        <li>ให้บริการแอปและปรับปรุงประสิทธิภาพ</li>
        <li>ดำเนินการติดต่อและรองรับคุณ</li>
        <li>ปรับปรุงและพัฒนาแอป</li>
        <li>ตรวจจับและป้องกันปัญหาด้านความปลอดภัย</li>
        <li>ปรับปรุงประสิทธิภาพของการเรียนรู้และการทดสอบ</li>
        <li>ส่งข้อมูลที่เป็นประโยชน์แก่คุณ เช่น ผลการเรียนรู้และคำแนะนำ</li>
        <li>การแจ้งเตือนและความยินยอม</li>
      </ul>

      <p>เราอาจส่งการแจ้งเตือนหรือขอความยินยอมเพิ่มเติมกับคุณในกรณีที่ต้องการเก็บข้อมูลที่มีความสำคัญมาก หรือในกรณีที่ต้องการนโยบายความเป็นส่วนตัวที่เฉพาะเจาะจง</p>

      <h3>การเปิดเผยข้อมูล</h3>

      <p>เราอาจเปิดเผยข้อมูลของคุณในกรณีที่จำเป็นตามกฎหมายหรือข้อบังคับที่เราต้องปฏิบัติ หรือในกรณีที่มีการละเมิดเงื่อนไขการใช้งานของเรา</p>

      <h3>ความปลอดภัยข้อมูล</h3>

      <p>เราจะรักษาความมั่นคงปลอดภัยของข้อมูลส่วนบุคคลของท่านไว้ตามหลักการการรักษาความลับ ความถูกต้องครบถ้วน และสภาพพร้อมใช้งาน เพื่อป้องกันการสูญหาย เข้าถึง ใช้ เปลี่ยนแปลง แก้ไข หรือเปิดเผย</p>

      <h3>การเข้าถึงและแก้ไขข้อมูล</h3>

      <p>คุณมีสิทธิ์ในการขอเข้าถึงข้อมูลของคุณและขอให้แก้ไขข้อมูลที่ไม่ถูกต้อง คุณสามารถทำการนี้โดยติดต่อเราผ่านทาง</p>
      <p>Email : Waragorn.T@outlook.com</p>

      <h3>การเก็บข้อมูลเป็นระยะเวลา</h3>

      <p>เราจะเก็บข้อมูลของคุณเท่าที่จำเป็นสำหรับวัตถุประสงค์ที่ระบุไว้ในนโยบายความเป็นส่วนตัวนี้ หากคุณไม่ใช้บริการของเราต่อเนื่องเราจะดำเนินการลบข้อมูลของคุณหรือทำให้ข้อมูลของคุณไม่สามารถระบุตัวตนได้</p>

      <h3>การเปลี่ยนแปลงนโยบาย</h3>

      <p>เราอาจทำการปรับปรุงนโยบายความเป็นส่วนตัวนี้เป็นครั้งคราว การเปลี่ยนแปลงจะถูกประกาศในหน้าแอปฯ ของเรา และคุณควรตรวจสอบนโยบายเป็นระยะเวลาเป็นครั้งคราว</p>
      
      <h3>ติดต่อเรา</h3>

      <p>หากคุณมีคำถามเกี่ยวกับนโยบายความเป็นส่วนตัวหรือการใช้ข้อมูลของคุณ โปรดติดต่อเราที่</p>
      <p>Email : Waragorn.T@outlook.com</p>
    </body>
  </html>
  """;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
      ),
      //title: const Center(child: Text("นโยบายความเป็นส่วนตัว")),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.9,
        child: SingleChildScrollView(
          child: Html(
            data: policy,
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Checkbox(
              value: checkBox,
              onChanged: (bool? value) {
                setState(() {
                  checkBox = value!;
                });
              },
            ),
            const Text(
              'ยอมรับ',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            checkBox != false
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      child: const Text(
                        'ยืนยัน',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        box.write('policy', 'accept');
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return LoginScreen();
                            },
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                          ModalRoute.withName('Login'),
                        );
                      },
                    ),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                      child: const Text(
                        'ยืนยัน',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        null;
                      },
                    ),
                  ),
            widthBox(MediaQuery.of(context).size.width * 0.05),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.20,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: const Text(
                  'ยกเลิก',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  box.write('policy', 'cancel');
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return LoginScreen();
                      },
                      transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                          Widget child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                    ModalRoute.withName('Login'),
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
          ],
        )
      ],
    );
  }
}
