import 'dart:io';

import 'gender_model.dart';

class DoctorModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String qualifications;
  final File? profileImage;
  final String address;
  final Gender gender;
  final String phoneNumber;
  final DateTime? birthday;
  DoctorModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.qualifications,
    required this.address,
    required this.gender,
    required this.phoneNumber,
    this.birthday,
    required this.profileImage,
  });

  String genderToString(Gender gender) {
    switch (gender) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'dFirstName': firstName,
      'dLastName': lastName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'profileImage': profileImage.toString(),
      'qualifications': qualifications,
      'address': address, // Convert address to JSON
      'gender': genderToString(gender),
      'phone': phoneNumber,
      'birthday': birthday?.toIso8601String(),
    };
  }
}
