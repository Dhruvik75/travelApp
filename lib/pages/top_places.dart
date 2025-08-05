import 'package:flutter/material.dart';

class topplace extends StatefulWidget {
  const topplace({super.key});

  @override
  State<topplace> createState() => _topplaceState();
}

class _topplaceState extends State<topplace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30)),
                        child: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 5),
                  Text(
                    "Top Places ",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      "images/bali.jpg",
                                      height: 300,
                                      width: 170,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 250),
                                    height: 50,
                                    width: 170,
                                    decoration: BoxDecoration(
                                        color: Colors.black45,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    child: Center(
                                      child: Text(
                                        "Bali ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30.0,
                                            fontFamily: 'pacifico',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      "images/delhi.jpg",
                                      height: 300,
                                      width: 170,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 250),
                                    height: 50,
                                    width: 170,
                                    decoration: BoxDecoration(
                                        color: Colors.black45,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    child: Center(
                                      child: Text(
                                        "Delhi ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30.0,
                                            fontFamily: 'pacifico',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      "images/Australia.jpg",
                                      height: 300,
                                      width: 170,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 250),
                                    height: 50,
                                    width: 170,
                                    decoration: BoxDecoration(
                                        color: Colors.black45,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    child: Center(
                                      child: Text(
                                        "Australia ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30.0,
                                            fontFamily: 'pacifico',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      "images/maxico.jpg",
                                      height: 300,
                                      width: 170,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 250),
                                    height: 50,
                                    width: 170,
                                    decoration: BoxDecoration(
                                        color: Colors.black45,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    child: Center(
                                      child: Text(
                                        "Mexico ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30.0,
                                            fontFamily: 'pacifico',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      "images/california.jpg",
                                      height: 300,
                                      width: 170,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 250),
                                    height: 50,
                                    width: 170,
                                    decoration: BoxDecoration(
                                        color: Colors.black45,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    child: Center(
                                      child: Text(
                                        " California ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30.0,
                                            fontFamily: 'pacifico',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      "images/burj.jpg",
                                      height: 300,
                                      width: 170,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 250),
                                    height: 50,
                                    width: 170,
                                    decoration: BoxDecoration(
                                        color: Colors.black45,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    child: Center(
                                      child: Text(
                                        " Dubai ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30.0,
                                            fontFamily: 'pacifico',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      "images/kedarnath.jpeg",
                                      height: 300,
                                      width: 170,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 250),
                                    height: 50,
                                    width: 170,
                                    decoration: BoxDecoration(
                                        color: Colors.black45,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    child: Center(
                                      child: Text(
                                        "Kedarnath ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30.0,
                                            fontFamily: 'pacifico',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      "images/manali.jpg",
                                      height: 300,
                                      width: 170,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 250),
                                    height: 50,
                                    width: 170,
                                    decoration: BoxDecoration(
                                        color: Colors.black45,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    child: Center(
                                      child: Text(
                                        "Manali",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30.0,
                                            fontFamily: 'pacifico',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
