import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/pages/compatibility_essentials_page.dart';
import 'package:railmates/models/compatibility_model.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/models/compatibility_destinations_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          spacing: 16.0,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FlexSizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CompatibilityEssentialsPage(),
                    ),
                  );
                },
                child: DataBuilder<CompatibilityModel?>(
                  builder: (context, data) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    elevation: 8.0,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.emoji_people,
                            size: 48.0,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 24.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 18.0,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      data?.dates ?? '-',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.today,
                                      size: 18.0,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      data?.days ?? '-',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.group,
                                      size: 18.0,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      data?.mates ?? '-',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.euro,
                                      size: 18.0,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      data?.budget ?? '-',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
              height: null,
              flex: 1,
              child: DataBuilder<List<CompatibilityDestinationsModel>>(
                builder: (context, data) => GridView.custom(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    childCount: data.length,
                    (context, index) {
                      final CompatibilityDestinationsModel element =
                          data[index];
                      return Material(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.onSurface,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        elevation: 5.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: SvgPicture(
                            SvgNetworkLoader(element.country_id!.flag_url!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
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
