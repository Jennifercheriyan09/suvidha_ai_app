import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';
import 'signup.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, size: 80, color: Color(0xFF6C63FF)),
                  SizedBox(height: 20),
                  Text('Welcome Back!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Log in to continue',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                  SizedBox(height: 30),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              final phone = phoneController.text.trim();
                              final password = passwordController.text.trim();

                              if (phone.isEmpty || password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please fill in both fields')),
                                );
                                return;
                              }

                              final fakeEmail = '$phone@suvidha.ai';

                              try {
                                await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: fakeEmail,
                                  password: password,
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                                );
                              } on FirebaseAuthException catch (e) {
                                String errorMsg = 'Login failed: ${e.message}';
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(errorMsg)),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF6C63FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                            ),
                            child: Text('Login',
                                style: TextStyle(color: Colors.white, fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6C63FF),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
