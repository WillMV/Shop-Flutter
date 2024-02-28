import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/exceptions/auth_exception.dart';
import 'package:shopping/models/auth_model.dart';

class AuthFormScreen extends StatefulWidget {
  const AuthFormScreen({super.key});

  @override
  State<AuthFormScreen> createState() => _AuthFormScreenState();
}

class _AuthFormScreenState extends State<AuthFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  final _userData = <String, String>{};

  bool _hasAccount = true;
  bool _isLoading = false;

  _showErrorDialog(String msg) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(msg.toString()),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'))
        ],
      ),
    );
  }

  _switchStateLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  _onSubmit() {
    Auth auth = Provider.of(context, listen: false);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_hasAccount) {
        auth.login(_userData['email']!, _userData['password']!);
      } else {
        auth.singUp(_userData['email']!, _userData['password']!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepOrange.shade800,
            Colors.deepPurple.shade800,
          ],
          transform: const GradientRotation(125),
        ),
      ),
      child: Center(
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                String email = value ?? '';
                                if (email.trim().isEmpty) {
                                  return "The email field must be filled.";
                                }
                                if (!email.contains('@') ||
                                    !email.contains('.')) {
                                  return "The email must be valid.";
                                }
                                return null;
                              },
                              onSaved: (newValue) =>
                                  _userData['email'] = newValue!,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Email'),
                              ),
                            ),
                            TextFormField(
                              obscureText: true,
                              textInputAction: _hasAccount
                                  ? TextInputAction.done
                                  : TextInputAction.next,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Password'),
                              ),
                              controller: _passwordController,
                              validator: (value) {
                                String password = value ?? '';

                                if (password.isEmpty) {
                                  return "The password field must be filled.";
                                }

                                if (password.length < 6) {
                                  return "The password must have a minimum length of 6 characters.";
                                }

                                return null;
                              },
                              onSaved: (newValue) =>
                                  _userData['password'] = newValue!,
                            ),
                            if (!_hasAccount)
                              TextFormField(
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text('Confirm the password'),
                                ),
                                validator: (value) {
                                  String password = value ?? '';

                                  if (password != _passwordController.text) {
                                    return 'The password in both fields must be the same.';
                                  }

                                  return null;
                                },
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _hasAccount = !_hasAccount;
                                      });
                                    },
                                    child: Text(_hasAccount
                                        ? 'Don\'t have an account?'
                                        : "Do you have an account?")),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        _switchStateLoading();
                                        _onSubmit();
                                        _switchStateLoading();
                                      } on AuthException catch (e) {
                                        _showErrorDialog(e.toString());
                                      } catch (_) {
                                        _showErrorDialog(
                                            "An unexpected error occurred.");
                                      }
                                    }
                                  },
                                  child:
                                      Text(_hasAccount ? 'Login' : 'Sing up'),
                                ),
                              ],
                            )
                          ]),
                    ),
            ),
          ),
        ),
      ),
    ));
  }
}
