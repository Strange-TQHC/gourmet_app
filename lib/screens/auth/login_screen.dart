import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscured = true;

  final auth = FirebaseAuth.instance;

  void login() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          /// --- DECORATIVE BACKGROUND CIRCLES ---
          // Top Left Circle
          Positioned(
            top: -50,
            left: -30,
            child: _buildCircle(150, Colors.orange.shade200.withOpacity(0.4)),
          ),

          // Top Right Circle (Smaller/Darker)
          Positioned(
            top: 40,
            right: -60,
            child: _buildCircle(120, Colors.orange.shade300.withOpacity(0.3)),
          ),

          // Bottom Right Circle (Large)
          Positioned(
            bottom: -80,
            right: -40,
            child: _buildCircle(200, Colors.orange.shade100.withOpacity(0.6)),
          ),

          // Bottom Left Circle
          Positioned(
            bottom: 20,
            left: -70,
            child: _buildCircle(140, Colors.orange.shade50.withOpacity(0.8)),
          ),

          /// --- LOGIN CONTENT ---
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    /// APP TITLE
                    const Center(
                      child: Text(
                        "Gourmet",
                        style: TextStyle(
                          fontFamily: "GourmetFont",
                          fontSize: 51,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    const Text(
                      "Login to continue",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// EMAIL
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// PASSWORD
                    TextField(
                      controller: passwordController,
                      obscureText: _isObscured,
                      decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// LOGIN BUTTON
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade100,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// NAVIGATION
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (
                              _) => const SignupScreen()),
                        );
                      },
                      child: const Text("Create account"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to build the circles
  Widget _buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}