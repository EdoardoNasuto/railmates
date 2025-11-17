import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/authentication_form.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/otp.dart';
import 'package:railmates/pages/login_page.dart';
import 'package:railmates/text_form.dart';

@NowaGenerated({'x': 420, 'y': 0, 'auto-width': 393.0, 'auto-height': 808.0})
class RegisterPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() {
    return _RegisterPageState();
  }
}

@NowaGenerated()
class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? firstNameController = TextEditingController();

  TextEditingController? lastNameController = TextEditingController();

  TextEditingController? birthDateController = TextEditingController();

  TextEditingController? emailController = TextEditingController();

  TextEditingController? passwordController = TextEditingController();

  TextEditingController? confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.18),
              Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withOpacity(0.85),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlexSizedBox(
                    child: AuthenticationForm(
                      nom: 'Create account',
                      buttonName: 'Sign up',
                      submitForm: () {
                        if (passwordController?.text ==
                            confirmPasswordController?.text) {
                          SupabaseService()
                              .signUp(
                                emailController!.text,
                                passwordController!.text,
                              )
                              .then(
                                (value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Registration successful!'),
                                    ),
                                  );
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Otp(email: emailController?.text),
                                    ),
                                  );
                                },
                                onError: (error) {
                                  if (error.toString().contains(
                                    'user_already_exist',
                                  )) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          'The email address is already associated with another account',
                                        ),
                                        backgroundColor: Theme.of(
                                          context,
                                        ).colorScheme.onErrorContainer,
                                      ),
                                    );
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(error.toString())),
                                    );
                                  }
                                },
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Password confirmation does not match',
                              ),
                            ),
                          );
                        }
                      },
                      textFields: [
                        TextForm(
                          label: 'Email',
                          required: true,
                          controller: emailController,
                          validators: [
                            RegExp(
                              '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}\$',
                            ),
                          ],
                          icon: Icons.email_outlined,
                          errorMessage: 'Invalid format',
                        ),
                        TextForm(
                          label: 'Password',
                          required: true,
                          obscure: true,
                          validators: [
                            RegExp(
                              '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}\$',
                              caseSensitive: true,
                              multiLine: false,
                              dotAll: false,
                            ),
                          ],
                          controller: passwordController,
                          icon: Icons.lock_outlined,
                          errorMessage:
                              'Required: 8+ chars, lowercase, uppercase, digit, symbol',
                        ),
                        TextForm(
                          label: 'Confirm password',
                          obscure: true,
                          required: true,
                          controller: confirmPasswordController,
                          icon: Icons.lock,
                          validators: [
                            RegExp(
                              '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}\$',
                            ),
                          ],
                          errorMessage:
                              'Required: 8+ chars, lowercase, uppercase, digit, symbol',
                        ),
                      ],
                      icon: Icons.app_registration,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
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
