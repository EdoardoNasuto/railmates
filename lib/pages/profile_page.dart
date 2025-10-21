import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/authentication_form.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/text_form.dart';
import 'package:railmates/pages/login_page.dart';

@NowaGenerated({'x': 420, 'y': 0, 'auto-width': 393.0, 'auto-height': 809.0})
class ProfilePage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() {
    return _ProfilePageState();
  }
}

@NowaGenerated()
class _ProfilePageState extends State<ProfilePage> {
  TextEditingController? firstNameController = TextEditingController();

  TextEditingController? lastNameController = TextEditingController();

  TextEditingController? birthDateController = TextEditingController();

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
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlexSizedBox(
                      child: AuthenticationForm(
                        nom: 'Créer ton profil',
                        buttonName: 'Enregistrer',
                        submitForm: () {
                          SupabaseService()
                              .updateProfile(
                            firstName: firstNameController?.text,
                            lastName: lastNameController?.text,
                            birthDate: birthDateController?.text,
                          )
                              .then(
                            (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Registration successful!'),
                                ),
                              );
                            },
                            onError: (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Error')),
                              );
                            },
                          );
                        },
                        textFields: [
                          TextForm(
                            label: 'First Name',
                            required: true,
                            controller: firstNameController,
                            icon: Icons.person_outline,
                          ),
                          TextForm(
                            label: 'Last Name',
                            required: true,
                            controller: lastNameController,
                            icon: Icons.person,
                          ),
                          TextForm(
                            label: 'Date de naissance',
                            dateField: true,
                            required: true,
                            controller: birthDateController,
                            icon: Icons.cake_outlined,
                          ),
                        ],
                        icon: Icons.person_pin,
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Déjà inscrit ?',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Connexion',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
