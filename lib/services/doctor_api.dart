import 'package:dio/dio.dart';
import 'package:eye_diseases/models/doc_reset_pass_model.dart';
import 'package:eye_diseases/models/doctor_model.dart';
import 'package:eye_diseases/models/doctors_patient_model.dart';
import 'package:eye_diseases/models/login_model.dart';
import 'package:eye_diseases/views/doc_form_screen.dart';
import 'package:eye_diseases/views/doc_login_screen.dart';
import 'package:eye_diseases/views/patients_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorApiService {
  final Dio _dio = Dio();
  final _storage = const FlutterSecureStorage();

  Future<String?> readDoctorToken() async {
    return await _storage.read(key: 'doctorToken');
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

  Future<void> registerDoctor(DoctorModel doctor, BuildContext context) async {
    try {
      final response = await _dio.post(
        'http://192.168.233.204:3000/doctor/register',
        data: doctor.toJson(),
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
            MaterialPageRoute(builder: (context) => const DocLoginScreen()));
      } else {
        print('Registration failed: ${response.statusCode}');
        print(response.data);
        _showErrorSnackbar(context, response.data['message']);
      }
    } on DioException catch (e) {
      _showErrorSnackbar(context,
          e.message ?? 'Network error.'); // Handle Dio exception message

      print('Error during registration: $e');
    }
  }

  Future<void> LoginDoctor(LoginModel login, BuildContext context) async {
    try {
      final response = await _dio.post(
        'http://192.168.233.204:3000/doctor/login',
        data: login.toJson(),
        options: Options(
          contentType: "application/json",
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSuccessSnackbar(context, 'Welcome to Eye-Conic');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response.data['results']);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientsListView(),
            ));
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
        'http://192.168.233.204:3000/doctor/forgetCode',
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
        'http://192.168.233.204:3000/doctor/resetPassword',
        data: reset.toJson(),
        options: Options(
          contentType: "application/json",
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSuccessSnackbar(context, 'Pasword Changed');
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

  Future<void> sendClinicPassword(String password, BuildContext context) async {
    try {
      final response = await _dio.post(
        'http://192.168.233.204:3000/doctor/ClinicPassword',
        data: {"clinicPassword": password},
        options: Options(
          contentType: "application/json",
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSuccessSnackbar(
            context, 'Congratulation fill your data to Continue');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DoctorRegistrationForm()));
      } else {
        print('Registration failed: ${response.statusCode}');
        print(response.data);
        _showErrorSnackbar(
            context, response.data['message']); // Or handle specific errors
      }
    } on DioException catch (e) {
      _showErrorSnackbar(context,
          e.message ?? 'Network error.'); // Handle Dio exception message

      print('Error : $e');
    }
  }

  Future<List<DoctorsPatientModel>> getAllPatient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Error: Missing patient token.');
    }

    try {
      final Response response = await Dio().get(
        'http://192.168.233.204:3000/doctor/history?FirstName',
        options: Options(
          headers: {
            'token': 'Route__$token', // Use Bearer token convention
          },
        ),
      );

      Map<String, dynamic> jsonData = response.data;
      List<dynamic> results = jsonData['patientHistory'] ??
          []; // Handle null or missing 'patientHistory'

      List<DoctorsPatientModel> patientList = [];

      for (var patient in results) {
        DoctorsPatientModel allpatient = DoctorsPatientModel(
          pFirstName:
              patient["pFirstName"] ?? 'N/A', // Provide default values if null
          pLastName: patient["pLastName"] ?? 'N/A',
          pImage: patient["image"],
        );
        patientList.add(allpatient);
      }
      return patientList;
    } on DioException catch (e) {
      print('Error during API request: $e');
      print('Response data: ${e.response?.data}');
      if (e.response?.statusCode == 500) {
        throw Exception('Server error: Failed to fetch patient data.');
      } else {
        throw Exception('Failed to fetch patient data.');
      }
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Unexpected error occurred.');
    }
  }

  Future<void> saveReport(
      String patientId, String? report, BuildContext context) async {
    // final token = await readPatientToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');

    if (token == null) {
      // Handle missing token (e.g., prompt user to login)
      _showErrorSnackbar(context, 'Error: Missing patient token.');
      return;
    }

    final url = 'http://192.168.233.204:3000/doctor/report'; // Assuming endpoint
    final options = Options(headers: {'token': 'Route__$token'});

    try {
      final response = await _dio.post(url,
          data: {"patientId": patientId, "report": report}, options: options);

      if (response.statusCode == 200) {
        print('saved successfully');
 _showSuccessSnackbar(
            context, 'saved report');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const PatientsListView()));
        // Handle successful response (e.g., navigate to confirmation screen)
      } else {
        print('Error during saving: ${response.statusCode}');
        print(response.data); // Check for error messages in response
      }
    } on DioException catch (e) {
      print('Error during API request: $e');
      _showErrorSnackbar(context, 'Network error.');
    }
  }
}
