import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/components/nav_bar.dart';

@NowaGenerated()
class ItineraryPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ItineraryPage({super.key});

  @override
  State<ItineraryPage> createState() {
    return _ItineraryPageState();
  }
}

@NowaGenerated()
class _ItineraryPageState extends State<ItineraryPage> {
  TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itinerary'),
        elevation: 1.0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: IconButton(
              onPressed: () {
                GoRouter.of(context).push('/profile');
              },
              icon: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
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
        child: SingleChildScrollView(
          child: SafeArea(
            minimum: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 24.0,
            ),
            child: Column(
              spacing: 24.0,
              children: [
                Material(
                  color: Theme.of(context).colorScheme.errorContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 10.0,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        Expanded(
                          child: Text(
                            'Cette fonctionnalité est en cours de développement. Coming soon!',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onErrorContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(12.0),
                  color: Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12.0,
                      children: [
                        const Row(
                          spacing: 12.0,
                          children: const [
                            CircleAvatar(child: Text('1')),
                            Text(
                              'Créer son itinéraire',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Créez votre itinéraire en ajoutant les villes et dates de chaque étape de votre voyage.',
                        ),
                        SizedBox(
                          child: Row(
                            spacing: 8.0,
                            children: [
                              const Icon(
                                Icons.location_city,
                                color: Colors.blue,
                              ),
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    labelText: 'Paris',
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: text,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
                              ),
                              const Expanded(
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: 'Lyon',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
                              ),
                              const Expanded(
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: 'Marseille',
                                    border: OutlineInputBorder(),
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
                Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(12.0),
                  color: Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12.0,
                      children: [
                        const Row(
                          spacing: 12.0,
                          children: const [
                            CircleAvatar(child: Text('2')),
                            Text(
                              'Voir les voyageurs',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Découvrez qui voyage au même endroit et à la même période que vous.',
                        ),
                        SizedBox(
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: const Text('Voyageur 1'),
                            subtitle: const Text(
                              'Il est là, pile au bon moment',
                            ),
                            trailing: const Icon(Icons.info_outline),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(12.0),
                  color: Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12.0,
                      children: [
                        const Row(
                          spacing: 12.0,
                          children: const [
                            CircleAvatar(child: Text('3')),
                            Text(
                              'Contacter des locaux',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Échangez avec des locaux pour obtenir des conseils et bons plans.',
                        ),
                        ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.location_on),
                          ),
                          title: const Text('Local 1'),
                          subtitle: const Text('Disponible pour discuter'),
                          trailing: const Icon(Icons.chat),
                          onTap: () {},
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
      bottomNavigationBar: const NavBar(index: 1),
    );
  }
}
