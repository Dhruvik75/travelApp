import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:random_string/random_string.dart';
import 'package:travel2/pages/home.dart';
import 'package:travel2/pages/login.dart';
import 'package:travel2/services/database.dart';
import 'package:travel2/services/shared_pref.dart';

import '../services/database.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  String email = "", password = "", name = "";
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();

  registration() async {
    if (password != "" &&
        namecontroller.text != "" &&
        emailcontroller.text != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String id = randomAlphaNumeric(10);
        Map<String, dynamic> userInfoMap = {
          "Name": namecontroller.text,
          "email": emailcontroller.text,
          "image":
              "https//www.istockphoto.com/photo/after-snowfall-kalka-shimla-railway-is-a-beautiful-place-in-india-gm1224392597-360000990",
          "id": id,
        };
        await SharedPreferenceHelper().savedUserName(namecontroller.text);
        await SharedPreferenceHelper().savedUserEmail(emailcontroller.text);
        await SharedPreferenceHelper().savedUserId(id);
        await SharedPreferenceHelper().savedUserImage(
          "https//www.istockphoto.com/photo/after-snowfall-kalka-shimla-railway-is-a-beautiful-place-in-india-gm1224392597-360000990",
        );

        await DatabaseMethods().addUserDetails(userInfoMap, id).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "registered Successfully",
                style: TextStyle(fontSize: 20.0, color: Colors.yellow),
              ),
            ),
          );
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => home()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'week-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Work",
                style: TextStyle(fontSize: 10.0),
              ),
            ),
          );
        } else if (e.code == "email-already-in-in-user") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        }
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
                  "images/signup.jpg",
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Signup",
                  style: TextStyle(color: Colors.white, fontSize: 40.0),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Name",
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
                  cursorColor: Colors.white,
                  controller: namecontroller,
                  decoration: InputDecoration(border: InputBorder.none),
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
                  cursorColor: Colors.white,
                  controller: emailcontroller,
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
                  cursorColor: Colors.white,
                  controller: passwordcontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 15.0),
              GestureDetector(
                onTap: () {
                  if (passwordcontroller.text != "" &&
                      namecontroller.text != "" &&
                      emailcontroller.text != "") {
                    setState(() {
                      name = namecontroller.text;
                      password = passwordcontroller.text;
                      email = emailcontroller.text;
                    });
                    registration();
                  }
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
                      "Sign up",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  "Already have an account? ",
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
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Center(
                  child: Text(
                    "Signin ",
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
