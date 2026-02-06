import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/components/auth_form.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/global_state.dart';
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
                      nom: GlobalState.of(context).localizations.createAccount,
                      buttonName: GlobalState.of(context).localizations.signUp,
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
                                    GlobalState.of(context)
                                        .localizations
                                        .checkEmailVerification,
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
                                        GlobalState.of(context)
                                            .localizations
                                            .errorRaised,
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
                                GlobalState.of(context)
                                    .localizations
                                    .passwordConfirmationMismatch,
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
                          label: GlobalState.of(context).localizations.email,
                          required: true,
                          requiredErrorMessage: GlobalState.of(context)
                              .localizations
                              .fieldRequired,
                          controller: emailController,
                          icon: Icons.email_outlined,
                          errorMessage: GlobalState.of(context)
                              .localizations
                              .invalidFormat,
                          regexValidator:
                              '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}\$',
                        ),
                        AuthTextFormField(
                          label: GlobalState.of(context).localizations.password,
                          required: true,
                          requiredErrorMessage: GlobalState.of(context)
                              .localizations
                              .fieldRequired,
                          obscure: true,
                          controller: passwordController,
                          icon: Icons.lock_outlined,
                          errorMessage: GlobalState.of(context)
                              .localizations
                              .passwordRequirements,
                          regexValidator:
                              '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}\$',
                        ),
                        AuthTextFormField(
                          label: GlobalState.of(context)
                              .localizations
                              .confirmPassword,
                          obscure: true,
                          required: true,
                          requiredErrorMessage: GlobalState.of(context)
                              .localizations
                              .fieldRequired,
                          controller: confirmPasswordController,
                          icon: Icons.lock,
                          errorMessage: GlobalState.of(context)
                              .localizations
                              .passwordRequirements,
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
                        Text(
                          GlobalState.of(context)
                              .localizations
                              .alreadyHaveAccount,
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
                            GlobalState.of(context).localizations.login,
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
