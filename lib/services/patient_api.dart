// import 'dart:js';

import 'package:dio/dio.dart';
import 'package:eye_diseases/models/all_doctor_model.dart';
import 'package:eye_diseases/models/doc_reset_pass_model.dart';
import 'package:eye_diseases/models/login_model.dart';
import 'package:eye_diseases/models/patient_model.dart';
import 'package:eye_diseases/views/choose_doctor_screen.dart';
import 'package:eye_diseases/views/pat_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientApiService {
  final Dio _dio = Dio();
  final _storage = const FlutterSecureStorage();

  Future<String?> readPatientToken() async {
    return await _storage.read(key: 'patientToken');
  }

  void _showErrorSnackbar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed: $errorMessage'),
        backgroundColor: Colors.red,
      ),
    );
  }
  void _showSuccessSnackbar(BuildContext context, String successMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$successMessage '),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> registerPatient(
      PatientModel patient, BuildContext context) async {
    try {
      final response = await _dio.post(
        'http://192.168.233.204:3000/patient/register',
        data: patient.toJson(),
        options: Options(
          contentType: "application/json",
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Registration successful!');
        _showSuccessSnackbar(
            context, 'Registration successful! check your mail to activate');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PatLoginScreen()));
      } else {
        _showErrorSnackbar(
            context, response.data['message']); // Or handle specific errors
      }
    } on DioException catch (e) {
      _showErrorSnackbar(context,
          e.message ?? 'Network error.'); // Handle Dio exception message

      print('Error during registration: $e');
    }
  }

  Future<void> LoginPatient(LoginModel login, BuildContext context) async {
    try {
      final response = await _dio.post(
        'http://192.168.233.204:3000/patient/login',
        data: login.toJson(),
        options: Options(
          contentType: "application/json",
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSuccessSnackbar(context, 'Welcome to Eye-Conic');

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChooseDoctorScreen(),
            ));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response.data['results']);
        print(response.data['results']);
      } else {
        _showErrorSnackbar(context, response.data['message']);
      }
    } on DioException catch (e) {
      print('Error during login: $e');
      _showErrorSnackbar(context, 'Error during login: $e');
    }
  }

  Future<void> sendForgetCode(String email, BuildContext context) async {
    try {
      final response = await _dio.patch(
        'http://192.168.233.204:3000/patient/forgetCode',
        data: {'email': email},
        options: Options(
          contentType: "application/json",
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSuccessSnackbar(context, 'Please Check your mail for the code');
      } else {
        print('Registration failed: ${response.statusCode}');
        print(response.data);
        _showErrorSnackbar(
            context, response.data['message']); // Or handle specific errors
      }
    } on DioException catch (e) {
      _showErrorSnackbar(context,
          e.message ?? 'Network error.'); // Handle Dio exception message

      print('Error during registration: $e');
    }
  }

  Future<void> resetPassword(ResetPassModel reset, BuildContext context) async {
    try {
      final response = await _dio.patch(
        'http://192.168.233.204:3000/patient/resetPassword',
        data: reset.toJson(),
        options: Options(
          contentType: "application/json",
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSuccessSnackbar(context, 'Pasword Changed');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatLoginScreen(),
            ));
      } else {
        print('failed: ${response.statusCode}');
        print(response.data);
        _showErrorSnackbar(
            context, response.data['message']); // Or handle specific errors
      }
    } on DioException catch (e) {
      _showErrorSnackbar(context,
          e.message ?? 'Network error.'); // Handle Dio exception message

      print('Error during reset: $e');
    }
  }

  Future<List<AllDoctors>> getAllDoctors() async {
    final Response response =
        await _dio.get('http://192.168.233.204:3000/doctor/allDoctor');
    Map<String, dynamic> jasonData = response.data;
    List<dynamic> results = jasonData['results'];
    List<AllDoctors> doctorsList = [];

    for (var doctors in results) {
      AllDoctors alldoctors = AllDoctors(
        id: doctors["_id"],
        email: doctors["email"],
        lname: doctors["dLastName"],
        fname: doctors["dFirstName"],
        phone: doctors["phone"],
        imageUrl: doctors["profileImage"]["url"],
        qualifications: doctors["qualifications"],
      );
      doctorsList.add(alldoctors);
    }
    return doctorsList;
  }

  Future<void> chooseDoctor(String doctorId, BuildContext context) async {
    // final token = await readPatientToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');

    if (token == null) {
      // Handle missing token (e.g., prompt user to login)
      _showErrorSnackbar(context, 'Error: Missing patient token.');
      return;
    }

    final url =
        'http://192.168.233.204:3000/patient/patients/choose-doctor/$doctorId'; // Assuming endpoint
    final options = Options(headers: {'token': 'Route__$token'});

    try {
      final response = await _dio.put(url, options: options);

      if (response.statusCode == 200) {
        print('Doctor chosen successfully!');
        // Handle successful response (e.g., navigate to confirmation screen)
      } else {
        print('Error choosing doctor: ${response.statusCode}');
        print(response.data); // Check for error messages in response
      }
    } on DioException catch (e) {
      print('Error during API request: $e');
      _showErrorSnackbar(context, 'Network error.');
    }
  }

  Future<void> uploadFundusImage(XFile imagePath, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      _showErrorSnackbar(context, 'Error: Missing patient token.');
      return;
    }

    const url = 'http://192.168.233.204.204:3000/patient/image';
    final options = Options(headers: {
      'token': 'Route__$token',
    });

    try {
      String fileName = imagePath.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          imagePath.path,
          filename: fileName,contentType:  MediaType("image", "jpeg")

        ),
      });

      final response = await Dio().post(
        url,
        data: formData,
        options: options,
      );
      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
        _showSuccessSnackbar(context, 'Image uploaded successfully!');
      } else {
        print('Error uploading image: ${response.statusCode}');
        print(response.data);
        _showErrorSnackbar(
            context, 'Error uploading image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during image upload: $e');
      _showErrorSnackbar(context, 'Network error.');
    }
  }
}
