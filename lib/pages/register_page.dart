import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/components/auth_form.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/pages/otp_page.dart';
import 'package:railmates/components/auth_text_form_field.dart';
import 'package:railmates/pages/login_page.dart';

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
                    child: AuthForm(
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
                                      content: Text(
                                        'Please check your email inbox for the verification code and enter it in app',
                                      ),
                                    ),
                                  );
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OtpPage(email: emailController?.text),
                                    ),
                                  );
                                },
                                onError: (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        RegExp('message:\\s*([^,]+)')
                                                .firstMatch(error.toString())
                                                ?.group(1) ??
                                            'Error raised',
                                      ),
                                      backgroundColor: Theme.of(
                                        context,
                                      ).colorScheme.error,
                                    ),
                                  );
                                },
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Password confirmation does not match',
                              ),
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.error,
                            ),
                          );
                        }
                      },
                      textFields: [
                        AuthTextFormField(
                          label: 'Email',
                          required: true,
                          controller: emailController,
                          icon: Icons.email_outlined,
                          errorMessage: 'Invalid format',
                          regexValidator:
                              '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}\$',
                        ),
                        AuthTextFormField(
                          label: 'Password',
                          required: true,
                          obscure: true,
                          controller: passwordController,
                          icon: Icons.lock_outlined,
                          errorMessage:
                              'Required: 8+ chars, lowercase, uppercase, digit, symbol',
                          regexValidator:
                              '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}\$',
                        ),
                        AuthTextFormField(
                          label: 'Confirm password',
                          obscure: true,
                          required: true,
                          controller: confirmPasswordController,
                          icon: Icons.lock,
                          errorMessage:
                              'Required: 8+ chars, lowercase, uppercase, digit, symbol',
                          regexValidator:
                              '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}\$',
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
                        const Text('Already have an account?'),
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
