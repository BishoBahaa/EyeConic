import 'gender_model.dart';

class PatientModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final Gender gender;
  final String phoneNumber;
  final DateTime? birthday;
  PatientModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.gender,
    required this.phoneNumber,
    this.birthday,
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
      'pFirstName': firstName,
      'pLastName': lastName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'gender': genderToString(gender),
      'phone': phoneNumber,
      'birthday': birthday?.toIso8601String(),
    };
  }
}
