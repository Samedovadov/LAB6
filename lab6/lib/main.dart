import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Registration',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _acceptTerms = false;
  bool _showPassword = false;

  String _selectedRole = 'Student';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  void _register() {
    final isFormValid = _formKey.currentState!.validate();

    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the Terms and Conditions')),
      );
      return;
    }

    if (!isFormValid) {
      return;
    }

    print('===== REGISTRATION DATA =====');
    print('Full Name: ${_nameController.text}');
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');
    print('Role: $_selectedRole');
    print('Terms accepted: $_acceptTerms');

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Registration successful!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Registration'), centerTitle: true),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Icon(Icons.person_add_alt_1, size: 80),

              const SizedBox(height: 15),

              const Text(
                'Create Account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Full Name is required';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'name@narxoz.kz',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }

                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Enter a valid email';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              TextFormField(
                controller: _passwordController,
                obscureText: !_showPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }

                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_showPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }

                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 22),

              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Select Role',
                  prefixIcon: Icon(Icons.badge),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Student', child: Text('Student')),
                  DropdownMenuItem(value: 'Teacher', child: Text('Teacher')),
                  DropdownMenuItem(
                    value: 'Developer',
                    child: Text('Developer'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
              ),

              const SizedBox(height: 15),

              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('I accept the Terms and Conditions'),
                value: _acceptTerms,
                onChanged: (value) {
                  setState(() {
                    _acceptTerms = value ?? false;
                  });
                },
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _register,
                  icon: const Icon(Icons.app_registration),
                  label: const Text('Register', style: TextStyle(fontSize: 17)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
