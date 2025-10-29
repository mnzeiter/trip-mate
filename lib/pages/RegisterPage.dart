// واجهة تسجيل مستخدم جديد

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _register() async {
    final first_name = fnameController.text;
    final last_name = lnameController.text;
    final nationality = nationalityController.text;
    final email = emailController.text;
    final password = passwordController.text;

    final response = await http.post(
      Uri.parse('https://saddlebrown-loris-518017.hostingersite.com/tourist/register'),
      body: jsonEncode({'email': email, 'password': password, 'first_name': first_name, 'last_name': last_name, 'nationality': nationality}),
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, '/login');
       dynamic result = jsonDecode(response.body);
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result['message']),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registration failed!'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // خلفية متدرجة الألوان
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade900, Colors.green.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // محتوى الصفحة
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // شعار أو صورة رمزية
                  Icon(Icons.person_add, size: 100, color: Colors.white),
                  SizedBox(height: 20),
                  // عنوان الصفحة
                  Text(
                    'Register Now!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please register in to continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                    SizedBox(height: 20),
                     _buildTextField(
                    controller: fnameController,
                    labelText: 'First Name',
                    icon: Icons.person,
                  ),
                    SizedBox(height: 20),
                     _buildTextField(
                    controller: lnameController,
                    labelText: 'Last Name',
                    icon: Icons.person_outline_outlined,
                  ),
                    SizedBox(height: 20),
                     _buildTextField(
                    controller: nationalityController,
                    labelText: 'Nationality',
                    icon: Icons.flag,
                  ),
                  SizedBox(height: 20),
                  // حقل إدخال البريد الإلكتروني
                  _buildTextField(
                    controller: emailController,
                    labelText: 'Email',
                    icon: Icons.email,
                  ),
                
                  SizedBox(height: 20),
                  // حقل إدخال كلمة المرور
                  _buildTextField(
                    controller: passwordController,
                    labelText: 'Password',
                    icon: Icons.lock,
                    
                  ),
                  SizedBox(height: 30),
                  // زر تسجيل الدخول
                  ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green.shade800,
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // رابط لإنشاء حساب جديد
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, '/Login');
                    },
                    child: Text(
                      'You have an account? Login',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // دالة مخصصة لإنشاء حقول الإدخال
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        prefixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
