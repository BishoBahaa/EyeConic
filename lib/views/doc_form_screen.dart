import 'dart:io';
import 'package:eye_diseases/models/doctor_model.dart';
import 'package:eye_diseases/util/form_validation.dart';
import 'package:eye_diseases/views/doc_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../models/gender_model.dart';
import 'package:eye_diseases/services/doctor_api.dart';

class DoctorRegistrationForm extends StatefulWidget {
  const DoctorRegistrationForm({super.key});

  @override
  State<DoctorRegistrationForm> createState() => _DoctorRegistrationFormState();
}

class _DoctorRegistrationFormState extends State<DoctorRegistrationForm> {
  bool _showPassword = false;
  ImagePicker picker = ImagePicker();
  File? _profileImage;
  // final Dio _dio = Dio();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _qualificationsController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  DateTime? _selectedBirthDate; // Store selected birth date

  Gender _selectedGender = Gender.male;

  String genderToString(Gender gender) {
    switch (gender) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, prepare data
      final doctor = DoctorModel(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        qualifications: _qualificationsController.text,
        profileImage: _profileImage,
        address: _addressController.text,
        gender: _selectedGender,
        phoneNumber: _phoneNumberController.text,
        birthday: _selectedBirthDate,
      );
      DoctorApiService().registerDoctor(doctor, context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Data,Check your data then try again'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _getImage() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (myfile != null) {
      FormValidation().validateImage(File(myfile.path));

      setState(() {
        _profileImage = File(myfile.path);
      });
    }
  }

  Widget _displayImage(BuildContext context) {
    // Now accepts context
    if (_profileImage == null) {
      return const Text('No image selected');
    } else {
      return Image.file(_profileImage!);
    }
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedBirthDate) {
      setState(() {
        _selectedBirthDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            )),
        title: const Text(
          'Register As Doctor',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff222744),
                Color(0xff485190),
              ],
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff222744),
                      Color(0xff485190),
                    ],
                  ),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(42))),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Image.asset(
                  'assets/images/eye-scan.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      prefixIcon: const Icon(Icons.abc_outlined),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      return FormValidation().fNameVal(value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      prefixIcon: const Icon(Icons.abc_outlined),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      return FormValidation().lNameVal(value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      prefixIcon: const Icon(Icons.email_rounded),
                    ),
                    keyboardType: TextInputType
                        .emailAddress, // Set appropriate keyboard type

                    validator: (value) {
                      return FormValidation().emailVal(value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      prefixIcon: const Icon(Icons.lock_rounded),
                      // Optional: Add an icon button to toggle password visibility
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Use appropriate icon based on visibility state:
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() => _showPassword = !_showPassword);
                        },
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText:
                        !_showPassword, // Control password visibility based on _showPassword state
                    validator: (value) {
                      return FormValidation().passwordVal(value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const ValueKey('confirmPassword'),
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      prefixIcon: const Icon(Icons.lock_rounded),
                      // Optional: Add an icon button to toggle password visibility
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Use appropriate icon based on visibility state:
                          _showPassword
                            ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() => _showPassword = !_showPassword);
                        },
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !_showPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password.';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      key: const ValueKey('address'),
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        prefixIcon: const Icon(Icons.location_on),
                      ),
                      keyboardType: TextInputType.streetAddress, // Set app
                      validator: (value) {
                        return FormValidation()
                            .validateField(value, "Address"); // Field is valid
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const ValueKey('qualifications'),
                    controller: _qualificationsController,
                    decoration: InputDecoration(
                      labelText: 'Qualifications (Separate by commas)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      prefixIcon: const Icon(Icons.workspace_premium_rounded),
                    ),
                    keyboardType: TextInputType.text, // Set app
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your qualifications.';
                      }

                      // Split the input string by commas (ignoring extra spaces)
                      final qualifications = value.trim().split(',');

                      // Check if all elements in the list are strings
                      if (qualifications.any((qualification) =>
                          qualification.trim().isEmpty ||
                          !RegExp(r'^[a-zA-Z]+$')
                              .hasMatch(qualification.trim()))) {
                        return 'Qualifications must be comma-separated strings with letters only.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _getImage,
                        child: const Text('Select Profile Image'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: _displayImage(context)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<Gender>(
                    value: _selectedGender,
                    hint: const Text('Select Gender'),
                    items: Gender.values // Efficiently generate items from enum
                        .map((gender) => DropdownMenuItem<Gender>(
                              value: gender,
                              child: Text(genderToString(gender)),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _selectedGender = value!),
                    validator: (value) {
                      return FormValidation().genderVal(value);
                    },
                    decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ) // Optional label for clarity
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const ValueKey('phoneNumber'),
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      errorText: FormValidation().phoneNumberError,
                      // Display error message if set
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      return FormValidation()
                          .phoneVal(value); // Phone number is valid
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () => _selectBirthDate(context),
                    child: Text(
                      _selectedBirthDate != null
                          ? DateFormat('yMMMMd').format(
                              _selectedBirthDate!) // Optional: formatted date (locale-aware)
                          : 'Select Birth Date',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: const Text('Submit'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const DocLoginScreen()),
                        ),
                      );
                    },
                    child: const Center(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "Have An Account ? ",
                        ),
                        TextSpan(
                            text: "Login",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 134, 128),
                                fontWeight: FontWeight.bold)),
                      ])),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
