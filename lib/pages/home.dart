import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Decode base64 string to Image widget
  Widget _buildPostImage(String base64String) {
    try {
      Uint8List bytes = base64Decode(base64String);
      return Image.memory(
        bytes,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 250,
      );
    } catch (e) {
      return Container(
        height: 250,
        color: Colors.grey,
        child: Center(child: Icon(Icons.broken_image)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Your existing UI part above
              Stack(
                children: [
                  Image.asset(
                    "images/image.jpg",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, right: 20.0),
                    child: Row(
                      children: [
                        Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              "images/world.jpg",
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Spacer(),
                        Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.blue,
                              size: 30.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(60),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.asset(
                              "images/boy.jpeg",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 130.0, left: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Travellers",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontSize: 40.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Travel Community App",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                      top: MediaQuery.of(context).size.height / 2.7,
                    ),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search your destination",
                            suffixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Display all posts fetched from Firestore
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection("posts")
                    .orderBy("timestamp", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "No posts found.",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    );
                  }
                  final posts = snapshot.data!.docs;

                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      final imageBase64 = post["imageBase64"] ?? "";
                      final place = post["place"] ?? "Unknown Place";
                      final city = post["city"] ?? "Unknown City";
                      final caption = post["caption"] ?? "";
                      final timestamp = post["timestamp"] as Timestamp?;

                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Post image
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                child: _buildPostImage(imageBase64),
                              ),

                              SizedBox(height: 10),

                              // Place & City
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on, color: Colors.blue),
                                    SizedBox(width: 5),
                                    Text(
                                      "$place, $city",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 8),

                              // Caption
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Text(
                                  caption,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                              SizedBox(height: 10),

                              // Timestamp (optional)
                              if (timestamp != null)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Text(
                                    "Posted on: ${timestamp.toDate().toLocal()}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),

                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              SizedBox(height: 50),

              // Your existing static post or any other UI below...
            ],
          ),
        ),
      ),
    );
  }
}
