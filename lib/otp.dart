import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/authentication_form.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:railmates/pages/profile_page.dart';
import 'package:railmates/text_form.dart';
import 'package:railmates/pages/register_page.dart';

@NowaGenerated({'auto-width': 393.0, 'x': 0, 'y': 0, 'auto-height': 808.5})
class Otp extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const Otp({this.email, super.key});

  final String? email;

  @override
  State<Otp> createState() {
    return _OtpState();
  }
}

@NowaGenerated()
class _OtpState extends State<Otp> {
  TextEditingController? tokenController = TextEditingController();

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
                children: [
                  AuthenticationForm(
                    submitForm: () {
                      SupabaseService()
                          .verifyOTP(
                            widget.email!,
                            tokenController!.text,
                            OtpType.email,
                          )
                          .then(
                            (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Email verified')),
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ProfilePage(),
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
                    },
                    textFields: [
                      TextForm(
                        label: 'Confirmation token',
                        required: true,
                        controller: tokenController,
                        obscure: true,
                        icon: Icons.generating_tokens_outlined,
                        validators: [RegExp('^\\d{6}\$')],
                        errorMessage: 'Token must be 6 digits',
                      ),
                      Align(
                        alignment: const Alignment(1.0, 0.0),
                        child: TextButton(
                          onPressed: () {
                            final emailController = TextEditingController(
                              text: widget.email ?? '',
                            );
                            showDialog<String>(
                              context: context,
                              useRootNavigator: false,
                              anchorPoint: const Offset(0.0, 0.0),
                              builder: (context) => AlertDialog(
                                title: const Text('Resend email'),
                                content: TextField(
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(
                                        context,
                                      ).pop(emailController.text);
                                    },
                                    child: const Text('Confirm'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              ),
                            ).then((confirmedEmail) {
                              if (confirmedEmail != null &&
                                  confirmedEmail!.isNotEmpty) {
                                SupabaseService()
                                    .resend(confirmedEmail!, OtpType.signup)
                                    .then(
                                      (value) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Email sent'),
                                          ),
                                        );
                                      },
                                      onError: (error) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              RegExp('message:\\s*([^,]+)')
                                                      .firstMatch(
                                                        error.toString(),
                                                      )
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
                                      'No email address provided',
                                    ),
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.error,
                                  ),
                                );
                              }
                            });
                          },
                          child: Text(
                            'Resend email?',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                    icon: Icons.generating_tokens_outlined,
                    nom: 'OTP',
                    buttonName: 'Verify',
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
                            'Not registered yet?',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Create account',
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
