import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class CompatibilityResultPage extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityResultPage({super.key});

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
          minimum: const EdgeInsets.only(
            top: 40.0,
            bottom: 40.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            spacing: 20.0,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlexSizedBox(
                width: double.infinity,
                height: null,
                child: ListTile(
                  title: Text(
                    'Tile',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: const Text('Dates', textAlign: TextAlign.center),
                ),
              ),
              FlexSizedBox(
                width: double.infinity,
                flex: 1,
                child: ListView.separated(
                  itemCount: 4,
                  itemBuilder: (context, index) => Material(
                    elevation: 5.0,
                    color: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const ListTile(
                      title: Text(
                        '{FirstName} {LastName}',
                        style: TextStyle(fontSize: 26.0),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        '{Age} {Region} {Country}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20.0, width: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
