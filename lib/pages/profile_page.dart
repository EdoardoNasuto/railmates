import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/text_form.dart';
import 'package:railmates/models/cities_model.dart';
import 'package:railmates/pages/city_research_page.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/models/profiles_model.dart';
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

  final PageController _pageController = PageController();

  int _currentPage = 0;

  final List<GlobalKey<FormState>> _formKeys = List.generate(
    5,
    (_) => GlobalKey<FormState>(),
  );

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        6,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: 12.0,
                          height: 12.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      padEnds: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Form(
                          key: _formKeys[0],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Ton prénom',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 24.0),
                              TextForm(
                                label: 'First Name',
                                icon: Icons.person_outline,
                                required: true,
                                controller: firstNameController,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.arrow_forward),
                                  onPressed: () {
                                    if (_formKeys[0].currentState?.validate() ??
                                        false) {
                                      _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Form(
                          key: _formKeys[1],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Ton nom',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 24.0),
                              TextForm(
                                label: 'Last Name',
                                icon: Icons.person,
                                required: true,
                                controller: lastNameController,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.arrow_forward),
                                  onPressed: () {
                                    if (_formKeys[1].currentState?.validate() ??
                                        false) {
                                      _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Form(
                          key: _formKeys[2],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Ta date de naissance',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 24.0),
                              TextForm(
                                label: 'Date de naissance',
                                icon: Icons.cake_outlined,
                                required: true,
                                dateField: true,
                                controller: birthDateController,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.arrow_forward),
                                  onPressed: () {
                                    if (_formKeys[2].currentState?.validate() ??
                                        false) {
                                      _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Form(
                          key: _formKeys[3],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Ta ville',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 24.0),
                              TextForm(
                                label: 'City',
                                icon: Icons.location_city,
                                required: true,
                                controller: cityController,
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
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.arrow_forward),
                                  onPressed: () {
                                    if (_formKeys[3].currentState?.validate() ??
                                        false) {
                                      _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Form(
                          key: _formKeys[4],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Ajoute une photo de profil',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 24.0),
                              TextButton(
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
                                    final bytes =
                                        await result.first.readAsBytes();
                                    setState(() {
                                      _avatarBytes = bytes;
                                    });
                                    try {
                                      await SupabaseService().avatarsUpload(
                                        _avatarBytes!,
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Avatar uploadé avec succès !',
                                          ),
                                        ),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Erreur upload avatar : ${e}',
                                          ),
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.85),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24.0),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Terminer ton profil',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 24.0),
                            ElevatedButton(
                              onPressed: () {
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
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Registration successful!',
                                        ),
                                      ),
                                    );
                                  },
                                  onError: (error) {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      const SnackBar(
                                        content: Text('Error'),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text('Enregistrer'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    children: [
                      if (_currentPage > 0)
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                              },
                              child: const Text('Précédent'),
                            ),
                          ),
                        ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: (_currentPage < 5)
                              ? TextButton(
                                  onPressed: () {
                                    if (_currentPage < 4) {
                                      if (_formKeys[_currentPage]
                                              .currentState
                                              ?.validate() ??
                                          false) {
                                        _pageController.nextPage(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.ease,
                                        );
                                      }
                                    } else {
                                      _pageController.nextPage(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                  child: const Text('Suivant'),
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
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
    );
  }
}
