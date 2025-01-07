import 'package:authentication/auth/auth_service.dart';
import 'package:authentication/screen/dashboard_screen.dart';
import 'package:authentication/screen/forgot_screen.dart';
import 'package:authentication/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();
  bool _isPasswordVisible = false;
  String _selectedCountryCode = '+91';
  TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 50),
                // const SizedBox(height: 50),
                const Text("Enter your mobile number"),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    prefixIcon: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: DropdownButton<String>(
                          value: _selectedCountryCode,
                          items: const [
                            DropdownMenuItem(
                              value: '+91',
                              child: Text('+91'),
                            ),
                            DropdownMenuItem(
                              value: '+62',
                              child: Text('+62'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedCountryCode = value!;
                            });
                          },
                          icon: const Icon(Icons.arrow_drop_down),
                        ),
                      ),
                    ),
                    // hintText: "1712345678",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: _phoneController.text.isNotEmpty
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Enter your password"),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    // hintText: "********",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotScreen()),
                      );
                    },
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()),
                        );
                      },
                      child: const Text("Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.black)),
                    ),
                  ],
                ),
                const Center(
                    child: Text("or",
                        style: TextStyle(fontWeight: FontWeight.w600))),
                const SizedBox(height: 10),
                Center(
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final userCredential = await _auth.loginWithGoogle();
                          if (userCredential != null &&
                              userCredential.user != null) {
                            // Navigasi ke Dashboard
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DashboardScreen(user: userCredential.user),
                              ),
                            );
                          } else {
                            // Tampilkan pesan error
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Login gagal. Silakan coba lagi.")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        icon: SvgPicture.asset(
                          'assets/google_icon.svg',
                          height: 20,
                        ),
                        label: const Text("Continue with Google"),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        icon: const Icon(Icons.apple),
                        label: const Text("Continue with Apple"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                    child: Text("or",
                        style: TextStyle(fontWeight: FontWeight.w600))),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Continue as Guest",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
