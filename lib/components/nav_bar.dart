import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:go_router/go_router.dart';
import 'package:railmates/integrations/supabase_service.dart';

@NowaGenerated({'auto-width': 300.0, 'auto-height': 58.0})
class NavBar extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const NavBar({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Material(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.groups,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                label: 'Summary',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.route,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                label: 'Itinerary',
              ),
            ],
            currentIndex: index,
            onTap: (value) async {
              if (value == index) {
                return;
              }
              if (value == 1) {
                GoRouter.of(context).go('/itinerary');
              } else {
                final complete = await SupabaseService()
                    .getUserCompatibilityComplete();
                if (complete) {
                  GoRouter.of(context).go('/');
                } else {
                  GoRouter.of(context).go('/home-page2');
                }
              }
            },
            elevation: 3.0,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          ),
        ),
      ),
    );
  }
}
