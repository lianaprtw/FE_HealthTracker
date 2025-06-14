import 'package:flutter/material.dart';
import 'package:health_tracker/views/Trainer/logintrainer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _specialistController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? selectedGender;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateFormState);
    _emailController.addListener(_updateFormState);
    _specialistController.addListener(_updateFormState);
    _passwordController.addListener(_updateFormState);
    _confirmPasswordController.addListener(_updateFormState);
  }

  void _updateFormState() {
    final valid = _validateInputsWithoutMessage();
    if (valid != isFormValid) {
      setState(() {
        isFormValid = valid;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  bool _validateInputsWithoutMessage() {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String specialist = _specialistController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    return name.isNotEmpty &&
        email.isNotEmpty &&
        selectedGender != null &&
        specialist.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword &&
        password.length >= 6 &&
        RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  bool _validateInputs() {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String specialist = _specialistController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        selectedGender == null ||
        specialist.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showSnackBar('Please fill in all the fields');
      return false;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      _showSnackBar('Please enter a valid email address');
      return false;
    }

    if (password.length < 6) {
      _showSnackBar('Password must be at least 6 characters');
      return false;
    }

    if (password != confirmPassword) {
      _showSnackBar('Passwords do not match');
      return false;
    }

    return true;
  }

  void _register() {
    if (_validateInputs()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registration Successful')));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                    color: Color(0xFF3742FA),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Welcome! Let’s get you started on your\njourney to better health',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              _buildLabel('Full Name'),
              _buildInput(_nameController, 'Enter your full name'),

              _buildLabel('Email'),
              _buildInput(_emailController, 'Enter your email'),

              _buildLabel('Gender'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F4FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedGender,
                    hint: const Text(
                      'Enter your gender',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    icon: const Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'Male',
                        child: Row(
                          children: [
                            Icon(Icons.male, color: Color(0xFF3742FA)),
                            SizedBox(width: 8),
                            Text(
                              'Male',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Female',
                        child: Row(
                          children: [
                            Icon(Icons.female, color: Color(0xFF3742FA)),
                            SizedBox(width: 8),
                            Text(
                              'Female',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                        _updateFormState();
                      });
                    },
                  ),
                ),
              ),

              _buildLabel('Specialist'),
              _buildInput(_specialistController, 'Enter your specialist'),

              _buildLabel('Password'),
              _buildInput(
                _passwordController,
                'Enter your password',
                obscureText: obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
              ),

              _buildLabel('Confirm Password'),
              _buildInput(
                _confirmPasswordController,
                'Enter your confirm password',
                obscureText: obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                ),
              ),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isFormValid ? const Color(0xFF3742FA) : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  onPressed: isFormValid ? _register : null,
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black54,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3742FA),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildInput(
    TextEditingController controller,
    String hintText, {
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: (v) => _updateFormState(),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontFamily: 'Poppins', color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFF2F4FF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
