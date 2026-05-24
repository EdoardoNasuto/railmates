import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/components/auth_form.dart';
import 'package:railmates/globals/locale_state.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:go_router/go_router.dart';
import 'package:railmates/components/auth_text_form_field.dart';

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
                      nom: LocaleState.of(context).l10n.createAccount,
                      buttonName: LocaleState.of(context).l10n.signUp,
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
                                    SnackBar(
                                      content: Text(
                                        LocaleState.of(
                                          context,
                                        ).l10n.checkEmailVerification,
                                      ),
                                    ),
                                  );
                                  GoRouter.of(context).pushNamed(
                                    'otp',
                                    queryParameters: {
                                      'email': emailController?.text ?? '',
                                      'otpType': 'signup',
                                    },
                                  );
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
                      textFields: [
                        AuthTextFormField(
                          label: LocaleState.of(context).l10n.email,
                          required: true,
                          requiredErrorMessage: LocaleState.of(
                            context,
                          ).l10n.fieldRequired,
                          controller: emailController,
                          icon: Icons.email_outlined,
                          errorMessage: LocaleState.of(
                            context,
                          ).l10n.invalidFormat,
                          regexValidator:
                              '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}\$',
                        ),
                        AuthTextFormField(
                          label: LocaleState.of(context).l10n.password,
                          required: true,
                          requiredErrorMessage: LocaleState.of(
                            context,
                          ).l10n.fieldRequired,
                          obscure: true,
                          controller: passwordController,
                          icon: Icons.lock_outlined,
                          errorMessage: LocaleState.of(
                            context,
                          ).l10n.passwordRequirements,
                          regexValidator:
                              '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}\$',
                        ),
                        AuthTextFormField(
                          label: LocaleState.of(context).l10n.confirmPassword,
                          obscure: true,
                          required: true,
                          requiredErrorMessage: LocaleState.of(
                            context,
                          ).l10n.fieldRequired,
                          controller: confirmPasswordController,
                          icon: Icons.lock,
                          errorMessage: LocaleState.of(
                            context,
                          ).l10n.passwordRequirements,
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
                        Text(LocaleState.of(context).l10n.alreadyHaveAccount),
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed('login');
                          },
                          child: Text(
                            LocaleState.of(context).l10n.login,
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
