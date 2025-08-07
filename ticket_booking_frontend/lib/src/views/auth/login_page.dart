import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool isLoading = false;
  String error = '';

  void _login() async {
    setState(() => isLoading = true);
    AuthService auth = Provider.of<AuthService>(context, listen: false);
    bool success = await auth.login(_emailCtrl.text, _passCtrl.text);
    setState(() {
      isLoading = false;
      error = success ? '' : 'Login failed';
    });
  }

  void _showSignup() {
    // Could push a signup page if implemented
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signup not implemented yet')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(Icons.event, size: 72, color: Color(0xFF1976D2)),
                const SizedBox(height: 24),
                Text('Ticket Booking', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 32),
                TextField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passCtrl,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                if (error.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(error, style: TextStyle(color: Colors.red)),
                ],
                const SizedBox(height: 24),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1976D2),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: _login,
                        child: const Text('Login'),
                      ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: _showSignup,
                  child: const Text('Sign up'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
