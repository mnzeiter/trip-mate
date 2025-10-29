import 'package:e_tourism/UserDate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String apiUrl = 'https://saddlebrown-loris-518017.hostingersite.com/tourist/login';  
  final TextEditingController emailController = TextEditingController(); 
  final TextEditingController passwordController = TextEditingController();
  dynamic userData;
  String result = ''; // To store the result from the API call 
  
  @override
  void initState() {
    userData = Provider.of<UserData>(context, listen: false);

    super.initState();
  }

  @override 
  void dispose() { 
    emailController.dispose(); 
    passwordController.dispose(); 


    super.dispose(); 
  } 
  
  Future<void> _login() async { 
    try { 
      final response = await http.post( 
        Uri.parse(apiUrl), 
        headers: <String, String>{ 
          'Content-Type': 'application/json; charset=UTF-8', 
        }, 
        body: jsonEncode(<String, dynamic>{ 
          'email': emailController.text, 
          'password': passwordController.text, 
          // Add any other data you want to send in the body 
        }), 
      ); 
  
      if (response.statusCode == 200) { 
        // Successful POST request, handle the response here 
        final responseData = jsonDecode(response.body); 
        setState(() { 
          result = 'data: ${responseData}'; 
        });
        print(result);

        if(responseData['login'] == true ){
          
           Navigator.of(context).pushNamedAndRemoveUntil('/tours', (Route<dynamic> route) => false);
           ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['message']),
        backgroundColor: Colors.green,
        ),);
        userData.userID = await responseData['id'];
        userData.tourID = await responseData['tour_id'];
        
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['message']),
        backgroundColor: Colors.red,
        ),);
        }
          
         
      } else { 
        // If the server returns an error response, throw an exception 
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed'),
          backgroundColor: Colors.red,
        
        ),
      );
        throw Exception('Failed to post data'); 
      } 
    } catch (e) { 
      setState(() { 
        result = 'Error: $e'; 
      }); 
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
                colors: [Colors.blue.shade900, Colors.blue.shade600],
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
                  Icon(Icons.lock, size: 100, color: Colors.white),
                  SizedBox(height: 20),
                  // عنوان الصفحة
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please log in to continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 30),
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
                    obscureText: true,
                  ),
                  SizedBox(height: 30),
                  // زر تسجيل الدخول
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                    ),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // زر تسجيل الدخول كمشرف
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/adminLogin');
                    },
                    child: Text(
                      'Login as Admin',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  SizedBox(height: 10),
                  // رابط لإنشاء حساب جديد
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'Don’t have an account? Create new account',
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
