import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:go_router/go_router.dart';

@NowaGenerated()
class SplashPage extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/europe_map.png'),
          ),
        ),
        child: Stack(
          alignment: const Alignment(0.0, 0.0),
          children: [
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xDCE1FF),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      spreadRadius: 0.0,
                      blurRadius: 100.0,
                      offset: const Offset(0.0, 0.0),
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                  child: Column(
                    spacing: 0.0,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FlexSizedBox(
                        width: null,
                        height: null,
                        child: Icon(
                          Icons.train,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                          size: 100.0,
                        ),
                      ),
                      FlexSizedBox(
                        width: null,
                        height: null,
                        child: Text(
                          'RailMates',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                            fontSize: 28.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const FlexSizedBox(
                        width: null,
                        height: null,
                        child: Text(
                          'Voyagez à travers l’Europe en toute simplicité',
                        ),
                      ),
                      FlexSizedBox(
                        width: null,
                        height: null,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              final complete = await SupabaseService()
                                  .getUserCompatibilityComplete();
                              if (complete) {
                                GoRouter.of(context).go('/');
                              } else {
                                GoRouter.of(context).go('/home-page2');
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color?>(
                                Theme.of(context).colorScheme.primary,
                              ),
                              foregroundColor:
                                  const WidgetStatePropertyAll<Color?>(null),
                              shadowColor: const WidgetStatePropertyAll<Color?>(
                                null,
                              ),
                              elevation: const WidgetStatePropertyAll<double?>(
                                null,
                              ),
                              side: const WidgetStatePropertyAll<BorderSide?>(
                                null,
                              ),
                              shape:
                                  const WidgetStatePropertyAll<
                                    RoundedRectangleBorder?
                                  >(null),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 8.0,
                              ),
                              child: Text(
                                'Commencer',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  fontSize: 28.0,
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
            ),
          ],
        ),
      ),
    );
  }
}
