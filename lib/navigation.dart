import 'package:firebase_auth/firebase_auth.dart';
import 'package:flitter/signup.dart';
import 'package:flitter/utils/variables.dart';
import 'package:flutter/material.dart';


import 'home.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  bool isSigned = false;

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    FirebaseAuth.instance.onAuthStateChanged.listen((useraccount) {
      if (useraccount != null) {
        setState(() {
          isSigned = true;
        });
      } else {
        setState(() {
          isSigned = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSigned == false ? Login() : HomePage(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var passwordcontroller = TextEditingController();
  var emailcontroller = TextEditingController();

  login() {
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text, password: passwordcontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "MINI IMAGE",
              style: mystyle(30, Colors.white, FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "เข้าสู่ระบบ",
              style: mystyle(25, Colors.white, FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 64,
              height: 64,
              child: Image.asset('images/flutter1.png'),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'อีเมล',
                    labelStyle: mystyle(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    prefixIcon: Icon(Icons.email)),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: passwordcontroller,
                obscureText: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'รหัสผ่าน',
                    labelStyle: mystyle(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    prefixIcon: Icon(Icons.lock)),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () => login(),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    'เข้าสู่ระบบ',
                    style: mystyle(20, Colors.black, FontWeight.w700),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ไม่มีบัญชี ?",
                  style: mystyle(20),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp())),
                  child: Text(
                    "ลงทะเบียน !",
                    style: mystyle(20, Colors.purple, FontWeight.w700),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
