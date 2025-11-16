import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/authentication_form.dart';
import 'package:railmates/models/profiles_model.dart';
import 'package:railmates/text_form.dart';
import 'package:railmates/models/cities_model.dart';
import 'package:railmates/pages/city_research_page.dart';
import 'package:railmates/pages/login_page.dart';

@NowaGenerated({'x': 420, 'y': 0, 'auto-width': 393.0, 'auto-height': 808.0})
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
  int? cityId;

  TextEditingController? firstNameController = TextEditingController();

  TextEditingController? lastNameController = TextEditingController();

  TextEditingController? birthDateController = TextEditingController();

  TextEditingController? cityController = TextEditingController();

  Uint8List? _avatarBytes;

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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () async {
                          final result = await showMediaPicker(
                            context: context,
                            multiSelection: false,
                            mediaType: MediaType.image,
                            sourceType: MediaSourceType.gallery,
                            preferredCamera: CameraDevice.rear,
                          );
                          if (result.isNotEmpty) {
                            final bytes = await result.first.readAsBytes();
                            setState(() {
                              _avatarBytes = bytes;
                            });
                            try {
                              await SupabaseService().avatarsUpload(
                                _avatarBytes!,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Avatar uploadé avec succès !'),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Erreur upload avatar : ${e}'),
                                ),
                              );
                            }
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 48.0,
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.surfaceVariant,
                              backgroundImage: _avatarBytes != null
                                  ? MemoryImage(_avatarBytes!)
                                  : null,
                            ),
                            if (_avatarBytes != null)
                              Container(
                                width: 96.0,
                                height: 96.0,
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.scrim.withOpacity(0.55),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            Container(
                              width: 96.0,
                              height: 96.0,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.add_a_photo,
                                size: 32.0,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.85),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FlexSizedBox(
                      child: AuthenticationForm(
                        nom: 'Créer ton profil',
                        buttonName: 'Enregistrer',
                        submitForm: () {
                          SupabaseService()
                              .updateProfiles(
                                ProfilesModel(
                                  city: cityId,
                                  first_name: firstNameController?.text,
                                  last_name: lastNameController?.text,
                                  birth_date: birthDateController?.text,
                                ),
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
                            interactiveSelection: false,
                          ),
                          TextForm(
                            label: 'City',
                            dateField: false,
                            required: true,
                            controller: cityController,
                            icon: Icons.location_city,
                            onChanged: null,
                            onTap: () async {
                              final CitiesModel? result =
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CityResearchPage(),
                                    ),
                                  );
                              cityController?.text = result!.name!;
                              cityId = result?.id;
                            },
                            interactiveSelection: false,
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
                        TextButton(
                          onPressed: () {
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
