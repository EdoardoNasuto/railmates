import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/pages/compatibility_essentials_page.dart';
import 'package:railmates/models/compatibility_model.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/models/compatibility_destinations_model.dart';
import 'package:railmates/components/nav_bar.dart';

@NowaGenerated()
class HomePage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

@NowaGenerated()
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: false,
        minimum: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          spacing: 10.0,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FlexSizedBox(
              width: double.infinity,
              height: 100.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CompatibilityEssentialsPage(),
                    ),
                  );
                },
                child: DataBuilder<CompatibilityModel?>(
                  builder: (context, data) => Material(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    elevation: 5.0,
                    child: Column(
                      spacing: 0.0,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FlexSizedBox(
                          width: null,
                          height: null,
                          child: Text(data!.dates!),
                        ),
                        FlexSizedBox(
                          width: null,
                          height: null,
                          child: Text(data!.days!),
                        ),
                        FlexSizedBox(
                          width: null,
                          height: null,
                          child: Text(data!.mates!),
                        ),
                        FlexSizedBox(
                          width: null,
                          height: null,
                          child: Text(data!.budget!),
                        ),
                      ],
                    ),
                  ),
                  loadingWidget: const Align(
                    alignment: Alignment(0.0, 0.0),
                    child: CircularProgressIndicator(),
                  ),
                  errorBuilder: (context, error) => Align(
                    alignment: const Alignment(0.0, 0.0),
                    child: Text(
                      error.toString(),
                      style: const TextStyle(color: Color(0xFFFF0000)),
                    ),
                  ),
                  future: SupabaseService().getUserCompatibility(),
                ),
              ),
            ),
            FlexSizedBox(
              width: double.infinity,
              height: 500.0,
              child: DataBuilder<List<CompatibilityDestinationsModel>>(
                builder: (context, data) => GridView.custom(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  childrenDelegate: SliverChildBuilderDelegate((
                    context,
                    index,
                  ) {
                    final CompatibilityDestinationsModel element = data[index];
                    return Text(element.country_id!.name!);
                  }, childCount: data.length),
                ),
                loadingWidget: const Align(
                  alignment: Alignment(0.0, 0.0),
                  child: CircularProgressIndicator(),
                ),
                errorBuilder: (context, error) => Align(
                  alignment: const Alignment(0.0, 0.0),
                  child: Text(
                    error.toString(),
                    style: const TextStyle(color: Color(0xFFFF0000)),
                  ),
                ),
                future: SupabaseService().getAllCompatibility_destinations(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(index: 0),
    );
  }
}
