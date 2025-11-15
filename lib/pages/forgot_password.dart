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
          minimum: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
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
                      icon: Icons.password,
                      textFields: [
                        TextForm(
                          label: 'Reset token',
                          icon: Icons.generating_tokens,
                          controller: tokenController,
                          required: true,
                        ),
                        TextForm(
                          label: 'New password',
                          controller: newPasswordController,
                          obscure: true,
                          required: true,
                          validators: [RegExp('^.{6,}\$')],
                        ),
                        const TextForm(
                          label: 'Confirm password',
                          required: true,
                          obscure: true,
                        ),
                      ],
                      submitForm: () {
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
                                            content: Text('Password changed !'),
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
                      },
                    ),
                  ),
                  FlexSizedBox(
                    width: null,
                    height: null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 8.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Revenir à l\'écran de connexion',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
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
