import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/components/authentication_form.dart';
import 'package:railmates/models/profiles_model.dart';
import 'package:railmates/components/text_form.dart';
import 'package:railmates/models/cities_model.dart';
import 'package:railmates/pages/city_research_page.dart';

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
          minimum: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
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
                                content: Text('Avatar uploaded successfully!'),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Avatar upload error: ${e}'),
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
                      nom: 'Create your profile',
                      buttonName: 'Save',
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
                          label: 'Birth Date',
                          readOnly: true,
                          required: true,
                          controller: birthDateController,
                          icon: Icons.cake_outlined,
                          onTap: () async {
                            DateTime defaultInitialDate = DateTime(
                              DateTime.now().year - 16,
                              DateTime.now().month,
                              DateTime.now().day,
                            );
                            DateTime initialDate = defaultInitialDate;
                            if (birthDateController != null &&
                                birthDateController!.text.isNotEmpty) {
                              try {
                                DateTime parsed = DateTime.parse(
                                  birthDateController!.text,
                                );
                                initialDate = parsed;
                              } catch (_) {}
                            }
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: initialDate,
                              firstDate: DateTime(
                                DateTime.now().year - 100,
                                DateTime.now().month,
                                DateTime.now().day,
                              ),
                              lastDate: DateTime(
                                DateTime.now().year - 16,
                                DateTime.now().month,
                                DateTime.now().day,
                              ),
                            );
                            if (picked != null && birthDateController != null) {
                              birthDateController?.text = picked!
                                  .toString()
                                  .split(' ')[0];
                              setState(() {});
                            }
                          },
                        ),
                        TextForm(
                          label: 'City',
                          readOnly: true,
                          required: true,
                          controller: cityController,
                          icon: Icons.location_city,
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
                        ),
                      ],
                      icon: Icons.person_pin,
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
