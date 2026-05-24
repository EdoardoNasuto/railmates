import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/components/auth_form.dart';
import 'package:railmates/globals/locale_state.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/models/profiles_model.dart';
import 'package:go_router/go_router.dart';
import 'package:railmates/components/auth_text_form_field.dart';
import 'package:railmates/models/cities_model.dart';

@NowaGenerated({'x': 420, 'y': 0, 'auto-width': 393.0, 'auto-height': 808.0})
class ProfileCreationPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ProfileCreationPage({super.key});

  @override
  State<ProfileCreationPage> createState() {
    return _ProfileCreationPageState();
  }
}

@NowaGenerated()
class _ProfileCreationPageState extends State<ProfileCreationPage> {
  int? cityId;

  TextEditingController? firstNameController = TextEditingController();

  TextEditingController? lastNameController = TextEditingController();

  TextEditingController? birthDateController = TextEditingController();

  TextEditingController? cityController = TextEditingController();

  TextEditingController? phoneController = TextEditingController();

  String? gender;

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
                      nom: LocaleState.of(context).l10n.createProfile,
                      buttonName: LocaleState.of(context).l10n.save,
                      submitForm: () {
                        SupabaseService()
                            .updateProfiles(
                              ProfilesModel(
                                city: cityId,
                                first_name: firstNameController?.text,
                                last_name: lastNameController?.text,
                                birth_date: birthDateController?.text,
                                phone: phoneController?.text,
                                gender: gender,
                              ),
                            )
                            .then(
                              (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      LocaleState.of(
                                        context,
                                      ).l10n.registrationSuccessful,
                                    ),
                                  ),
                                );
                                GoRouter.of(context).go('/');
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
                      },
                      textFields: [
                        AuthTextFormField(
                          label: LocaleState.of(context).l10n.firstName,
                          required: true,
                          requiredErrorMessage: LocaleState.of(
                            context,
                          ).l10n.fieldRequired,
                          controller: firstNameController,
                          icon: Icons.person_outline,
                        ),
                        AuthTextFormField(
                          label: LocaleState.of(context).l10n.lastName,
                          required: true,
                          requiredErrorMessage: LocaleState.of(
                            context,
                          ).l10n.fieldRequired,
                          controller: lastNameController,
                          icon: Icons.person,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 0.0,
                          ),
                          child: DropdownButtonFormField<String>(
                            items: [
                              DropdownMenuItem<String>(
                                value: 'W',
                                child: Text(LocaleState.of(context).l10n.women),
                              ),
                              DropdownMenuItem<String>(
                                value: 'M',
                                child: Text(LocaleState.of(context).l10n.man),
                              ),
                            ],
                            onChanged: (value) {
                              gender = value;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.transgender,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              labelText: '',
                              hintText: LocaleState.of(context).l10n.gender,
                              filled: true,
                              fillColor: Theme.of(
                                context,
                              ).colorScheme.surfaceContainer,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                            iconSize: 24.0,
                            elevation: 8,
                            validator: (value) {
                              if (value == null || value!.isEmpty) {
                                return LocaleState.of(
                                  context,
                                ).l10n.fieldRequired;
                              }
                              return null;
                            },
                          ),
                        ),
                        AuthTextFormField(
                          label: LocaleState.of(context).l10n.birthDate,
                          required: true,
                          requiredErrorMessage: LocaleState.of(
                            context,
                          ).l10n.fieldRequired,
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
                              birthDateController?.text = picked
                                  .toString()
                                  .split(' ')[0];
                              setState(() {});
                            }
                          },
                        ),
                        AuthTextFormField(
                          label: LocaleState.of(context).l10n.city,
                          required: true,
                          requiredErrorMessage: LocaleState.of(
                            context,
                          ).l10n.fieldRequired,
                          controller: cityController,
                          icon: Icons.location_city,
                          onTap: () async {
                            final CitiesModel? result = await context
                                .pushNamed<CitiesModel?>('city_search');
                            cityController?.text = result!.name!;
                            cityId = result?.id;
                          },
                        ),
                        AuthTextFormField(
                          label: LocaleState.of(context).l10n.phone,
                          regexValidator: '^\\+[1-9]\\d{6,14}\$',
                          required: true,
                          requiredErrorMessage: LocaleState.of(
                            context,
                          ).l10n.fieldRequired,
                          errorMessage: LocaleState.of(
                            context,
                          ).l10n.invalidFormat,
                          controller: phoneController,
                          icon: Icons.phone_paused_sharp,
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
