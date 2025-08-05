import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel2/pages/home.dart';
import 'package:travel2/pages/signup.dart';
import 'package:travel2/services/database.dart';
import 'package:travel2/services/shared_pref.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "", password = "", myname = "", myid = "", myimage = "";
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      QuerySnapshot querySnapshot = await DatabaseMethods().getUserByEmail(
        email,
      );

      myname = "${querySnapshot.docs[0]["Name"]}";
      myid = "${querySnapshot.docs[0]["id"]}";
      myimage = "${querySnapshot.docs[0]["image"]}";

      await SharedPreferenceHelper().savedUserImage(myimage);
      await SharedPreferenceHelper().savedUserName(myname);
      await SharedPreferenceHelper().savedUserId(myid);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => home()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user not found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "no user found",
              style: TextStyle(fontSize: 10.0, color: Colors.yellow),
            ),
          ),
        );
      } else if (e.code == 'wrong password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "wrong password",
              style: TextStyle(fontSize: 10.0, color: Colors.yellow),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(100),
                ),
                child: Image.asset(
                  "images/login.jpg",
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 40.0),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Email",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.only(left: 30.0),
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white38),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: emailcontroller,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Password",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.only(left: 30.0),
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white38),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  obscureText: true,
                  controller: passwordcontroller,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.white24,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              GestureDetector(
                onTap: () {
                  if (emailcontroller != "" && passwordcontroller != "") {
                    setState(() {
                      email = emailcontroller.text;
                      password = passwordcontroller.text;
                    });
                  }
                  userLogin();
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xfffc9502),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Center(
                child: Text(
                  "or",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/google.jpg",
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Login with Google ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => signup()),
                  );
                },
                child: Center(
                  child: Text(
                    "Signup ",
                    style: TextStyle(
                      color: Color(0xfffea720),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
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
