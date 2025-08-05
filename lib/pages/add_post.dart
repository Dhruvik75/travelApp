import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  XFile? _pickedFile;

  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  Future<void> _uploadPostToFirestore() async {
    if (_pickedFile == null ||
        _placeController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _captionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields and image are required")),
      );
      return;
    }

    try {
      Uint8List imageBytes;

      if (kIsWeb) {
        imageBytes = await _pickedFile!.readAsBytes();
      } else {
        imageBytes = await File(_pickedFile!.path).readAsBytes();
      }

      final base64Image = base64Encode(imageBytes);

      await FirebaseFirestore.instance.collection("posts").add({
        "imageBase64": base64Image,
        "place": _placeController.text.trim(),
        "city": _cityController.text.trim(),
        "caption": _captionController.text.trim(),
        "timestamp": Timestamp.now(),
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("✅ Post uploaded successfully")));

      _placeController.clear();
      _cityController.clear();
      _captionController.clear();
      setState(() {
        _pickedFile = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Upload failed: $e")));
    }
  }

  Widget _buildImage() {
    if (_pickedFile == null) {
      return Center(
        child: Icon(Icons.camera_alt_outlined, size: 50, color: Colors.black45),
      );
    } else {
      if (kIsWeb) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            _pickedFile!.path,
            fit: BoxFit.cover,
            width: 100,
            height: 100,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.red),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(child: CircularProgressIndicator());
            },
          ),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(
            File(_pickedFile!.path),
            fit: BoxFit.cover,
            width: 100,
            height: 100,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.red),
              );
            },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 40),
              child: Row(
                children: [
                  Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 4.5),
                  Text(
                    "Add Post ",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.0),

            Expanded(
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 30.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200],
                              ),
                              child: _buildImage(),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.0),

                        buildLabel("Place name"),
                        buildInputField("Enter Place Name", _placeController),

                        SizedBox(height: 20.0),

                        buildLabel("City Name"),
                        buildInputField("Enter City Name", _cityController),

                        SizedBox(height: 20.0),

                        buildLabel("Caption"),
                        Container(
                          padding: EdgeInsets.only(left: 20.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFececf8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _captionController,
                            maxLength: 30,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Caption......",
                            ),
                          ),
                        ),

                        SizedBox(height: 30.0),

                        Center(
                          child: GestureDetector(
                            onTap: _uploadPostToFirestore,
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  " Post ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabel(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.blue,
        fontSize: 27.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildInputField(String hint, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        color: Color(0xFFececf8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint),
      ),
    );
  }
}
