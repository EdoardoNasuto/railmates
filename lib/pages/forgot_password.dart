import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/authentication_form.dart';
import 'package:railmates/text_form.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/pages/login_page.dart';

@NowaGenerated()
class ForgotPassword extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ForgotPassword({this.email = '', super.key});

  final String? email;

  @override
  State<ForgotPassword> createState() {
    return _ForgotPasswordState();
  }
}

@NowaGenerated()
class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController? tokenController = TextEditingController();

  TextEditingController? confirmNewPasswordController = TextEditingController();

  TextEditingController? newPasswordController = TextEditingController();

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
              reverse: false,
              primary: false,
              scrollDirection: Axis.vertical,
              clipBehavior: Clip.hardEdge,
              child: Column(
                spacing: 0.0,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlexSizedBox(
                    child: AuthenticationForm(
                      nom: 'Reset password',
                      icon: Icons.lock_reset,
                      textFields: [
                        TextForm(
                          label: 'Reset token',
                          icon: Icons.generating_tokens_outlined,
                          controller: tokenController,
                          required: true,
                          obscure: true,
                          errorMessage: 'Token must be 6 digits',
                          validators: [RegExp('^\\d{6}\$')],
                        ),
                        TextForm(
                          label: 'New password',
                          controller: newPasswordController,
                          obscure: true,
                          required: true,
                          validators: [
                            RegExp(
                              '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}\$',
                            ),
                          ],
                          icon: Icons.lock_outlined,
                          errorMessage:
                              'Required: 8+ chars, lowercase, uppercase, digit, symbol',
                        ),
                        TextForm(
                          label: 'Confirm password',
                          required: true,
                          obscure: true,
                          icon: Icons.lock,
                          errorMessage:
                              'Required: 8+ chars, lowercase, uppercase, digit, symbol',
                          validators: [
                            RegExp(
                              '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}\$',
                            ),
                          ],
                          controller: confirmNewPasswordController,
                        ),
                      ],
                      submitForm: () {
                        if (newPasswordController?.text ==
                            confirmNewPasswordController?.text) {
                          SupabaseService()
                              .verifyOTP(widget.email!, tokenController!.text)
                              .then(
                                (result) {
                                  SupabaseService()
                                      .updateUser(
                                        widget.email,
                                        newPasswordController?.text,
                                      )
                                      .then(
                                        (value) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Password successfully changed !',
                                              ),
                                            ),
                                          );
                                        },
                                        onError: (error) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(error.toString()),
                                            ),
                                          );
                                        },
                                      );
                                },
                                onError: (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error.toString())),
                                  );
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
                      buttonName: 'Reset password',
                    ),
                  ),
                  FlexSizedBox(
                    width: double.infinity,
                    child: Padding(
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
                            'Remember it?',
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
