import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/components/auth_form.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/global_state.dart';
import 'package:go_router/go_router.dart';
import 'package:railmates/components/auth_text_form_field.dart';

@NowaGenerated({'auto-width': 393.0, 'x': 0, 'y': 0, 'auto-height': 808.5})
class LoginPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

@NowaGenerated()
class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController? passwordController = TextEditingController();

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
                          .signIn(
                            emailController.text,
                            passwordController!.text,
                          )
                          .then(
                            (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    GlobalState.of(
                                      context,
                                    ).localizations.loginSuccessful,
                                  ),
                                ),
                              );
                              GoRouter.of(context).go('/');
                            },
                            onError: (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    RegExp('message:s*([^,]+)')
                                            .firstMatch(error.toString())
                                            ?.group(1) ??
                                        GlobalState.of(
                                          context,
                                        ).localizations.errorRaised,
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
                      AuthTextFormField(
                        label: GlobalState.of(context).localizations.email,
                        required: true,
                        requiredErrorMessage: GlobalState.of(
                          context,
                        ).localizations.fieldRequired,
                        controller: emailController,
                        obscure: false,
                        icon: Icons.email_outlined,
                        errorMessage: GlobalState.of(
                          context,
                        ).localizations.invalidFormat,
                        regexValidator:
                            '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}\$',
                      ),
                      AuthTextFormField(
                        label: GlobalState.of(context).localizations.password,
                        required: true,
                        requiredErrorMessage: GlobalState.of(
                          context,
                        ).localizations.fieldRequired,
                        controller: passwordController,
                        obscure: true,
                        icon: Icons.lock_outline_rounded,
                        errorMessage: GlobalState.of(
                          context,
                        ).localizations.passwordRequirements,
                        regexValidator:
                            '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}\$',
                      ),
                      Align(
                        alignment: const Alignment(1.0, 0.0),
                        child: TextButton(
                          onPressed: () {
                            SupabaseService()
                                .resetPasswordForEmail(emailController.text)
                                .then(
                                  (value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          GlobalState.of(
                                            context,
                                          ).localizations.emailSent,
                                        ),
                                      ),
                                    );
                                    GoRouter.of(context).pushNamed(
                                      'otp',
                                      queryParameters: {
                                        'email': emailController.text,
                                        'otpType': 'recovery',
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
                          child: Text(
                            GlobalState.of(
                              context,
                            ).localizations.forgotPassword,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                    icon: Icons.account_circle_outlined,
                    nom: GlobalState.of(context).localizations.login,
                    buttonName: GlobalState.of(context).localizations.login,
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
                            GlobalState.of(
                              context,
                            ).localizations.notRegisteredYet,
                          ),
                          TextButton(
                            onPressed: () {
                              GoRouter.of(context).pushNamed('register');
                            },
                            child: Text(
                              GlobalState.of(
                                context,
                              ).localizations.createAccount,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
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
