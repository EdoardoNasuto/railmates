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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 32.0),
              Container(
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
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18.0,
                      horizontal: 20.0,
                    ),
                    hintText: 'Rechercher une ville',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.5),
                        ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              FlexSizedBox(
                width: 339.0,
                height: 689.5,
                child: CityResearch(city: searchPrefixController.text),
              ),
              const SizedBox(height: 32.0),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
