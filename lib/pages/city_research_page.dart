import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/city_research.dart';

@NowaGenerated({'auto-height': 807.5})
class CityResearchPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CityResearchPage({super.key});

  @override
  State<CityResearchPage> createState() {
    return _CityResearchPageState();
  }
}

@NowaGenerated()
class _CityResearchPageState extends State<CityResearchPage> {
  TextEditingController searchPrefixController = TextEditingController(
    text: 'pari',
  );

  @override
  void initState() {
    super.initState();
    searchPrefixController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlexSizedBox(
              width: double.infinity,
              child: Container(
                width: 340.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.shadow.withOpacity(0.07),
                      blurRadius: 12.0,
                      offset: const Offset(0.0, 4.0),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: searchPrefixController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18.0,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18.0,
                      horizontal: 10.0,
                    ),
                    hintText: 'Rechercher une ville',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.5),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            FlexSizedBox(
              width: double.infinity,
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 8.0,
                ),
                child: CityResearch(city: searchPrefixController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
