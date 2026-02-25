import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated({'auto-width': 300.0, 'auto-height': 58.0})
class NavBar extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const NavBar({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.view_list,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          label: 'Summary',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: index,
      onTap: (value) {},
      elevation: 3.0,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
    );
  }
}
