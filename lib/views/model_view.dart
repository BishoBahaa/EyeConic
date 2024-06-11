import 'dart:convert';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ModelView extends StatefulWidget {
  final String imageUrl; // Accept image URL as a parameter

  ModelView({required this.imageUrl});

  @override
  _ModelViewState createState() => _ModelViewState();
}

class _ModelViewState extends State<ModelView> {
  String body = "";
  String? disease;
  double? confidence;
  String? base64Image; // Base64 representation of the image

  @override
  void initState() {
    super.initState();
    _loadImageFromUrl(); // Load image from URL when the screen is initialized
  }

  Future<void> _loadImageFromUrl() async {
    try {
      final response = await http.get(Uri.parse(widget.imageUrl)); // Fetch image from the URL
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        setState(() {
          base64Image = base64Encode(bytes); // Convert bytes to base64 string
        });
      } else {
        throw Exception("Failed to load image");
      }
    } catch (e) {
      print("Error loading image: $e");
    }
  }

  Future predict() async {
    if (base64Image == null) return "";

    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/x-www-form-urlencoded',
      };

      var response = await http.post(
        Uri.parse("https://classify.roboflow.com/theeyedismodel/1?api_key=HMVd15jfQhNSkA3Qm7to"),
        body: base64Image,
        headers: requestHeaders);

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        if (jsonResponse['confidence'] >= 0.80) {
          disease = jsonResponse['top'];
          confidence = jsonResponse['confidence'] * 100;
        } else {
          disease = 'Not eye fundus';
          confidence = 100.0;
        }

        body = response.body;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        disease = 'Error';
        confidence = 0.0;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:62.0,right:62.0 ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: base64Image != null
                      ? Image.network(
                          widget.imageUrl) // Display the image from the URL
                      : Container(), // Display an empty container while loading
                ),
              ),
              SizedBox(height: 20),
              disease != null
                  ? Text(
                      "Disease: $disease",
                      style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 110, 9)),
                    )
                  : Text(
                      "Disease:",
                      style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 110, 9)),
                    ),
              SizedBox(height: 20),
              confidence != null
                  ? Text(
                      "Confidence: $confidence",
                      style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 110, 9)),
                    )
                  : Text(
                      "Confidence:",
                      style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 110, 9)),
                    ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 0, 79, 119)),
                    onPressed: () {
                      if (base64Image != null) {
                        predict();
                      } else {
                        print("Image is not loaded yet.");
                      }
                    },
                    child: Text('Check'),
                  ),
                   ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 0, 79, 119)),
                    onPressed: () {
                      if (base64Image != null) {
                        // predict();
                      } else {
                        print("Image is not loaded yet.");
                      }
                    },
                    child: Text('Save report'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
