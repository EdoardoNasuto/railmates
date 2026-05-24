import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/components/auth_form.dart';
import 'package:railmates/globals/locale_state.dart';
import 'package:railmates/components/auth_text_form_field.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:go_router/go_router.dart';

@NowaGenerated()
class ForgotPasswordPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ForgotPasswordPage({this.email = '', super.key});

  final String? email;

  @override
  State<ForgotPasswordPage> createState() {
    return _ForgotPasswordPageState();
  }
}

@NowaGenerated()
class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
                    child: AuthForm(
                      nom: LocaleState.of(context).l10n.resetPassword,
                      icon: Icons.lock_reset,
                      textFields: [
                        AuthTextFormField(
                          label: LocaleState.of(context).l10n.newPassword,
                          controller: newPasswordController,
                          obscure: true,
                          required: true,
                          requiredErrorMessage: LocaleState.of(
                            context,
                          ).l10n.fieldRequired,
                          icon: Icons.lock_outlined,
                          errorMessage: LocaleState.of(
                            context,
                          ).l10n.passwordRequirements,
                          regexValidator:
                              '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}\$',
                        ),
                        AuthTextFormField(
                          label: LocaleState.of(context).l10n.confirmPassword,
                          required: true,
                          requiredErrorMessage: LocaleState.of(
                            context,
                          ).l10n.fieldRequired,
                          obscure: true,
                          icon: Icons.lock,
                          errorMessage: LocaleState.of(
                            context,
                          ).l10n.passwordRequirements,
                          controller: confirmNewPasswordController,
                          regexValidator:
                              '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}\$',
                        ),
                      ],
                      submitForm: () {
                        if (newPasswordController?.text ==
                            confirmNewPasswordController?.text) {
                          SupabaseService()
                              .updateUser(
                                widget.email,
                                newPasswordController?.text,
                              )
                              .then(
                                (value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        LocaleState.of(
                                          context,
                                          listen: false,
                                        ).l10n.passwordSuccessfullyChanged,
                                      ),
                                    ),
                                  );
                                  GoRouter.of(context).push('/');
                                },
                                onError: (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        RegExp('message:\\s*([^,]+)')
                                                .firstMatch(error.toString())
                                                ?.group(1) ??
                                            LocaleState.of(
                                              context,
                                            ).l10n.errorRaised,
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
                              content: Text(
                                LocaleState.of(
                                  context,
                                ).l10n.passwordConfirmationMismatch,
                              ),
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.error,
                            ),
                          );
                        }
                      },
                      buttonName: LocaleState.of(context).l10n.resetPassword,
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
