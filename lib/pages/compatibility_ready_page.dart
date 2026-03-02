import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/global_state.dart';
import 'package:railmates/i18n/app_localizations.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/models/compatibility_model.dart';
import 'package:railmates/pages/compatibility_group_page.dart';

@NowaGenerated()
class CompatibilityReadyPage extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityReadyPage({super.key});

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
          minimum: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlexSizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 26.0,
                    horizontal: 0.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 16.0,
                          offset: const Offset(0.0, 8.0),
                        ),
                      ],
                    ),
                    width: 120.0,
                    height: 120.0,
                    child: Center(
                      child: Icon(
                        Icons.people_alt,
                        size: 72.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              FlexSizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 0.0,
                  ),
                  child: Text(
                    GlobalState.of(context).localizations.readyToFindMateTitle,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8.0,
                          offset: const Offset(0.0, 2.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              FlexSizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 0.0,
                  ),
                  child: Text(
                    AppLocalizations.of(context).readyToFindMateSubtitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              FlexSizedBox(
                width: null,
                height: null,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 32.0,
                    bottom: 16.0,
                    left: 0.0,
                    right: 0.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      SupabaseService().updateCompatibility(
                        const CompatibilityModel(ready: true),
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CompatibilityGroupPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color?>(
                        Theme.of(context).colorScheme.primary,
                      ),
                      foregroundColor: WidgetStatePropertyAll<Color?>(
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                      shadowColor: const WidgetStatePropertyAll<Color?>(null),
                      elevation: const WidgetStatePropertyAll<double?>(6.0),
                      side: const WidgetStatePropertyAll<BorderSide?>(null),
                      shape:
                          const WidgetStatePropertyAll<RoundedRectangleBorder?>(
                            null,
                          ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 0.0,
                      ),
                      child: Text(
                        AppLocalizations.of(context).readyButtonLabel,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          height: 1.43,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FlexSizedBox(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppLocalizations.of(context).notYet,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
