import 'dart:io';

import 'package:eye_diseases/models/gender_model.dart';

class FormValidation {
  final RegExp phoneRegExp = RegExp(r'^\+?[0-9]+$');
  String? phoneNumberError;



   String? fNameVal(String? value) {
     if (value == null || value.isEmpty) {
      return 'Please enter your first name.';
    } else if (value.length < 3 || value.length > 20) {
      return 'First name must be between 3 and 20 characters.';
    }
    return null;
  }
   String? lNameVal(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name.';
    } else if (value.length < 3 || value.length > 20) {
      return 'First name must be between 3 and 20 characters.';
    }
    return null;
  }

    String? emailVal(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Email validation regex
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email format.';
    }
    return null;
  }
  bool validatePhoneNumber(String phoneNumber) {
    return phoneRegExp.hasMatch(phoneNumber) &&
        phoneNumber.length >= 8 &&
        phoneNumber.length <= 15;
  }

  String? phoneVal(String? value) {
    
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number.';
    } else if (!validatePhoneNumber(value)) {
      phoneNumberError = 'Invalid phone number format.';
      return null; // Don't return a specific error message for overall form validation
    }
    return null;
  }

  String? genderVal(Gender? value) {
     if (value == null) {
      return 'Please select your gender.';
    }
    return null;
  }

  String? passwordVal(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }
    
    // Consider adding more complex validation rules (e.g., minimum length, character types)
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }

     RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    if (!regex.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and minimum 8 characters';
    }
    return null;
  }

    String? validateField(String? value, String field) {
    if (value == null || value.isEmpty) {
      return 'Enter your $field ';
    }
    return null; // Field is valid
  }

    void validateImage(File imageFile) {
    // Example validation: check if image is a valid image file
    if (!imageFile.path.endsWith('.jpg') &&
        !imageFile.path.endsWith('.jpeg') &&
        !imageFile.path.endsWith('.png')) {
      // Show error message: "Please select a valid image (jpg, jpeg, or png)"
      return;
    }

    // You can add more validation rules here (e.g., size limit)

  }
}
