import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/components/auth_form.dart';
import 'package:railmates/global_state.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/models/profiles_model.dart';
import 'package:railmates/components/auth_text_form_field.dart';
import 'package:railmates/models/cities_model.dart';
import 'package:railmates/pages/city_search_page.dart';

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
                      nom: GlobalState.of(context).localizations.createProfile,
                      buttonName: GlobalState.of(context).localizations.save,
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
                                      GlobalState.of(
                                        context,
                                      ).localizations.registrationSuccessful,
                                    ),
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
                          label: GlobalState.of(
                            context,
                          ).localizations.firstName,
                          required: true,
                          requiredErrorMessage: GlobalState.of(
                            context,
                          ).localizations.fieldRequired,
                          controller: firstNameController,
                          icon: Icons.person_outline,
                        ),
                        AuthTextFormField(
                          label: GlobalState.of(context).localizations.lastName,
                          required: true,
                          requiredErrorMessage: GlobalState.of(
                            context,
                          ).localizations.fieldRequired,
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
                                child: Text(
                                  GlobalState.of(context).localizations.women,
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'M',
                                child: Text(
                                  GlobalState.of(context).localizations.man,
                                ),
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
                              hintText: GlobalState.of(
                                context,
                              ).localizations.gender,
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
                                return GlobalState.of(
                                  context,
                                ).localizations.fieldRequired;
                              }
                              return null;
                            },
                          ),
                        ),
                        AuthTextFormField(
                          label: GlobalState.of(
                            context,
                          ).localizations.birthDate,
                          required: true,
                          requiredErrorMessage: GlobalState.of(
                            context,
                          ).localizations.fieldRequired,
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
                          label: GlobalState.of(context).localizations.city,
                          required: true,
                          requiredErrorMessage: GlobalState.of(
                            context,
                          ).localizations.fieldRequired,
                          controller: cityController,
                          icon: Icons.location_city,
                          onTap: () async {
                            final CitiesModel? result =
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CitySearchPage(),
                                  ),
                                );
                            cityController?.text = result!.name!;
                            cityId = result?.id;
                          },
                        ),
                        AuthTextFormField(
                          label: GlobalState.of(context).localizations.phone,
                          regexValidator: '^\\+[1-9]\\d{6,14}\$',
                          required: true,
                          requiredErrorMessage: GlobalState.of(
                            context,
                          ).localizations.fieldRequired,
                          errorMessage: GlobalState.of(
                            context,
                          ).localizations.invalidFormat,
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
