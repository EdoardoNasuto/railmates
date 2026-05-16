import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/global_state.dart';
import 'package:railmates/models/cities_model.dart';
import 'package:go_router/go_router.dart';
import 'package:railmates/globals/app_state.dart';
import 'package:railmates/globals/themes.dart';
import 'package:railmates/components/nav_bar.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/models/profiles_model.dart';

@NowaGenerated()
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
  TextEditingController? firstName = TextEditingController();

  TextEditingController? lastName = TextEditingController();

  TextEditingController? birthDate = TextEditingController();

  bool visible = true;

  String? gender = '';

  TextEditingController city = TextEditingController();

  int? cityId = 0;

  TextEditingController phone = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.surface,
            ],
            begin: const AlignmentGeometry.xy(1.0, -1.0),
            end: const AlignmentGeometry.xy(1.0, 1.0),
          ),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            spacing: 0.0,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FlexSizedBox(
                width: double.infinity,
                height: null,
                flex: 1,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Visibility(
                      visible: visible,
                      replacement: const Align(
                        alignment: Alignment(0.0, 0.0),
                        child: CircularProgressIndicator(),
                      ),
                      child: Column(
                        spacing: 30.0,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlexSizedBox(
                            width: double.infinity,
                            child: Material(
                              elevation: 1.0,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: GlobalState.of(
                                    context,
                                    listen: false,
                                  ).localizations.firstName,
                                ),
                                controller: firstName,
                                validator: (value) {
                                  if (value == null || value!.isEmpty) {
                                    return 'Field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          FlexSizedBox(
                            width: double.infinity,
                            child: Material(
                              elevation: 1.0,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: GlobalState.of(
                                    context,
                                    listen: false,
                                  ).localizations.lastName,
                                ),
                                controller: lastName,
                                validator: (value) {
                                  if (value == null || value!.isEmpty) {
                                    return 'Field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          FlexSizedBox(
                            width: null,
                            height: null,
                            child: Material(
                              elevation: 1.0,
                              child: DropdownButtonFormField<String>(
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'M',
                                    child: Text(
                                      GlobalState.of(
                                        context,
                                        listen: false,
                                      ).localizations.man,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'W',
                                    child: Text(
                                      GlobalState.of(
                                        context,
                                        listen: false,
                                      ).localizations.women,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                                initialValue: gender,
                                onChanged: (value) {
                                  gender = value;
                                },
                                decoration: InputDecoration(
                                  labelText: GlobalState.of(
                                    context,
                                    listen: false,
                                  ).localizations.gender,
                                  border: const OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value!.isEmpty) {
                                    return 'Field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          FlexSizedBox(
                            width: double.infinity,
                            child: Material(
                              elevation: 1.0,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: GlobalState.of(
                                    context,
                                    listen: false,
                                  ).localizations.birthDate,
                                ),
                                controller: birthDate,
                                onTap: () {
                                  showDatePicker(
                                    initialDate: DateTime.parse(
                                      birthDate!.text,
                                    ),
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
                                    useRootNavigator: false,
                                    context: context,
                                    anchorPoint: const Offset(0.0, 0.0),
                                    initialEntryMode: DatePickerEntryMode.input,
                                  );
                                },
                                validator: (value) {
                                  if (value == null || value!.isEmpty) {
                                    return 'Field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          FlexSizedBox(
                            width: double.infinity,
                            child: Material(
                              elevation: 1.0,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: GlobalState.of(
                                    context,
                                    listen: false,
                                  ).localizations.city,
                                ),
                                controller: city,
                                onTap: () async {
                                  final CitiesModel? result = await context
                                      .pushNamed<CitiesModel?>('city_search');
                                  city.text = result!.name!;
                                  cityId = result?.id;
                                },
                                validator: (value) {
                                  if (value == null || value!.isEmpty) {
                                    return 'Field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          FlexSizedBox(
                            width: double.infinity,
                            child: Material(
                              elevation: 1.0,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: GlobalState.of(
                                    context,
                                    listen: false,
                                  ).localizations.phone,
                                ),
                                controller: phone,
                                validator: (value) {
                                  if (value == null || value!.isEmpty) {
                                    return 'Field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              FlexSizedBox(
                width: null,
                height: null,
                child: Switch(
                  value: AppState.of(context).theme == darkTheme,
                  onChanged: (value) {
                    if (value) {
                      AppState.of(
                        context,
                        listen: false,
                      ).changeTheme(darkTheme);
                    } else {
                      AppState.of(
                        context,
                        listen: false,
                      ).changeTheme(lightTheme);
                    }
                  },
                  thumbIcon: const WidgetStatePropertyAll<Icon?>(
                    Icon(Icons.dark_mode),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(index: 1),
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 1.0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        shadowColor: Theme.of(context).colorScheme.shadow,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            SupabaseService()
                .updateProfiles(
                  ProfilesModel(
                    first_name: firstName?.text,
                    last_name: lastName?.text,
                    gender: gender,
                    birth_date: birthDate?.text,
                    city: cityId,
                    phone: phone.text,
                  ),
                )
                .then(
                  (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Success',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        elevation: 3.0,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                      ),
                    );
                  },
                  onError: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Error',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onErrorContainer,
                          ),
                        ),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.errorContainer,
                      ),
                    );
                    return null;
                  },
                );
          }
        },
        child: const Icon(Icons.save_as),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }

  @override
  void initState() {
    visible = false;
    super.initState();
    SupabaseService().getUserProfile().then((value) async {
      firstName?.text = value!.first_name!;
      lastName?.text = value!.last_name!;
      birthDate?.text = value!.birth_date!;
      gender = value?.gender;
      cityId = value?.city;
      phone.text = value!.phone!;
      final var1 = await SupabaseService().getByIdCities(cityId!);
      city.text = var1!.name!;
      visible = true;
      setState(() {});
    });
  }
}
