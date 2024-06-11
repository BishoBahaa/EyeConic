class ResetPassModel {
  String email;
  String code;
  String password;
  String confirmPassword;
  ResetPassModel({required this.email,required this.code, required this.password,required this.confirmPassword});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'forgetCode':code,
      'password': password,
      'confirmPassword':confirmPassword,
    };
  }
}

