import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/authentication_form.dart';
import 'package:railmates/text_form.dart';
import 'package:railmates/integrations/supabase_service.dart';

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
                        ),
                        TextForm(
                          label: 'New password',
                          controller: newPasswordController,
                          obscure: true,
                          required: true,
                          validators: [RegExp('^.{6,}\$')],
                          icon: Icons.lock_outlined,
                        ),
                        const TextForm(
                          label: 'Confirm password',
                          required: true,
                          obscure: true,
                          icon: Icons.lock,
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
                      buttonName: 'Reset password',
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
