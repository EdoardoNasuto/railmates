import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/global_state.dart';
import 'package:railmates/components/nav_bar.dart';
import 'package:go_router/go_router.dart';

@NowaGenerated()
class HomePage2 extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() {
    return _HomePage2State();
  }
}

@NowaGenerated()
class _HomePage2State extends State<HomePage2> {
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
          minimum: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            spacing: 10.0,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: [
              FlexSizedBox(
                width: null,
                height: null,
                child: Icon(
                  Icons.train,
                  color: Theme.of(context).colorScheme.primary,
                  size: 100.0,
                ),
              ),
              FlexSizedBox(
                height: null,
                width: double.infinity,
                child: Material(
                  color: Theme.of(context).colorScheme.surface,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 20.0,
                    ),
                    child: Column(
                      spacing: 0.0,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FlexSizedBox(
                          child: Text(
                            GlobalState.of(
                              context,
                            ).localizations.readyToFindMateTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 28.0,
                            ),
                          ),
                        ),
                        FlexSizedBox(
                          child: Text(
                            GlobalState.of(
                              context,
                            ).localizations.readyToFindMateSubtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FlexSizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 0.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color?>(
                        Theme.of(context).colorScheme.primary,
                      ),
                      foregroundColor: WidgetStatePropertyAll<Color?>(
                        Theme.of(context).colorScheme.shadow,
                      ),
                      shadowColor: const WidgetStatePropertyAll<Color?>(null),
                      elevation: const WidgetStatePropertyAll<double?>(5.0),
                      side: const WidgetStatePropertyAll<BorderSide?>(null),
                      shape:
                          const WidgetStatePropertyAll<RoundedRectangleBorder?>(
                            null,
                          ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 0.0,
                      ),
                      child: Text(
                        GlobalState.of(context).localizations.readyButtonLabel,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(index: 0),
      appBar: AppBar(
        title: const Text('Summary'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 1.0,
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
    );
  }
}
