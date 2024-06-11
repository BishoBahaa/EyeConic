import 'dart:io';
import 'package:eye_diseases/services/patient_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SendImage extends StatefulWidget {
  @override
  _SendImageState createState() => _SendImageState();
}

class _SendImageState extends State<SendImage> {
  String body = "";
  String? disease;
  double? confidence;

  XFile? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile ?image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = XFile(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffd0d4fc), // Same as app bar background

        appBar: AppBar(
          backgroundColor: Color(0xff485190),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16.0),
            ),
          ),
          elevation: 4,
          title: Text(
            'Eye-Conic 👁️',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 250,
                    height: 250,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: _imageFile != null
                            ? Image.file(File(_imageFile!.path)) // Convert XFile to File
                            : Center(
                                child: Container(
                                child: Text(
                                  "Upload Fundus Image",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              )))),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 0, 79, 119)),
                      onPressed: _pickImage,
                      child: Text('Upload Image'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 0, 79, 119)),
                      onPressed: () {
                        if (_imageFile != null) {
                          PatientApiService().uploadFundusImage((_imageFile!), context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please select an image first'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Text('Send'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
