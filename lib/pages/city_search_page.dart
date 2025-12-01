import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/components/place_search_bar.dart';
import 'package:railmates/components/city_search_builder.dart';

@NowaGenerated({'auto-height': 808.0, 'auto-width': 393.0})
class CitySearchPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CitySearchPage({super.key});

  @override
  State<CitySearchPage> createState() {
    return _CitySearchPageState();
  }
}

@NowaGenerated()
class _CitySearchPageState extends State<CitySearchPage> {
  TextEditingController? SearchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlexSizedBox(
              width: double.infinity,
              child: PlaceSearchBar(
                controller: SearchBarController,
                onChange: (value) {
                  setState(() {});
                },
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
                child: CitySearchBuilder(prefix: SearchBarController?.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
