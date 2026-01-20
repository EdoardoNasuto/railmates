import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/components/auth_form.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:railmates/pages/profile_page.dart';
import 'package:railmates/pages/forgot_password_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

@NowaGenerated({'auto-width': 393.0, 'x': 0, 'y': 0, 'auto-height': 808.5})
class OtpPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const OtpPage({this.email = '', this.otpType = OtpType.signup, super.key});

  final String? email;

  final OtpType? otpType;

  @override
  State<OtpPage> createState() {
    return _OtpPageState();
  }
}

@NowaGenerated()
class _OtpPageState extends State<OtpPage> {
  TextEditingController? tokenController = TextEditingController();

  TextEditingController? emailController = TextEditingController();

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
                  AuthForm(
                    submitForm: () {
                      SupabaseService()
                          .verifyOTP(
                            emailController!.text,
                            tokenController!.text,
                            widget.otpType!,
                          )
                          .then(
                            (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Account verified'),
                                ),
                              );
                              if (widget.otpType == OtpType.signup) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const ProfilePage(),
                                  ),
                                );
                              } else {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordPage(),
                                  ),
                                );
                              }
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
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        pinTheme: PinTheme(inactiveColor: Color(0xff000000)),
                        controller: tokenController,
                        onChanged: (value) {},
                      ),
                      Align(
                        alignment: const Alignment(1.0, 0.0),
                        child: TextButton(
                          onPressed: () {
                            showDialog(
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
                                      if (widget.otpType == OtpType.recovery) {
                                        SupabaseService()
                                            .resetPasswordForEmail(
                                              emailController?.text,
                                            )
                                            .then(
                                              (value) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Email resent',
                                                    ),
                                                  ),
                                                );
                                                Navigator.of(context).pop();
                                              },
                                              onError: (error) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      RegExp('message:\\s*([^,]+)')
                                                              .firstMatch(
                                                                error
                                                                    .toString(),
                                                              )
                                                              ?.group(1) ??
                                                          'Error raised',
                                                    ),
                                                    backgroundColor: Theme.of(
                                                      context,
                                                    ).colorScheme.error,
                                                  ),
                                                );
                                                Navigator.of(context).pop();
                                              },
                                            );
                                      } else {
                                        SupabaseService()
                                            .resend(
                                              emailController!.text,
                                              widget.otpType!,
                                            )
                                            .then(
                                              (value) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Email resent',
                                                    ),
                                                  ),
                                                );
                                                Navigator.of(context).pop();
                                              },
                                              onError: (error) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      RegExp('message:\\s*([^,]+)')
                                                              .firstMatch(
                                                                error
                                                                    .toString(),
                                                              )
                                                              ?.group(1) ??
                                                          'Error raised',
                                                    ),
                                                    backgroundColor: Theme.of(
                                                      context,
                                                    ).colorScheme.error,
                                                  ),
                                                );
                                                Navigator.of(context).pop();
                                              },
                                            );
                                      }
                                    },
                                    child: const Text('Confirm'),
                                  ),
                                ],
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.onPrimary,
                                shadowColor: Theme.of(
                                  context,
                                ).colorScheme.shadow,
                              ),
                            );
                          },
                          child: Text(
                            'Resend email?',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                    icon: Icons.generating_tokens_outlined,
                    nom: 'OTP',
                    buttonName: 'Verify',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    emailController?.text = widget.email!;
  }
}
