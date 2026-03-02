import 'package:flutter/material.dart';
import 'package:railmates/models/compatibility_destinations_model.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/global_state.dart';
import 'package:railmates/models/countries_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:railmates/pages/compatibility_questions_page.dart';

@NowaGenerated()
class CompatibilityDestinationsPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityDestinationsPage({super.key});

  @override
  State<CompatibilityDestinationsPage> createState() {
    return _CompatibilityDestinationsPageState();
  }
}

@NowaGenerated()
class _CompatibilityDestinationsPageState
    extends State<CompatibilityDestinationsPage> {
  List<CompatibilityDestinationsModel>? selectedCountries = [];

  bool visible = true;

  @override
  void initState() {
    visible = false;
    super.initState();
    _loadSelectedCountries();
  }

  Future<void> _loadSelectedCountries() async {
    selectedCountries = await SupabaseService()
        .getAllCompatibility_destinations();
    visible = true;
    setState(() {});
  }

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
          minimum: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlexSizedBox(
                width: null,
                height: null,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                    bottom: 15.0,
                    left: 0.0,
                    right: 0.0,
                  ),
                  child: Text(
                    GlobalState.of(context).localizations.onlyChoose10Countries,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              FlexSizedBox(
                width: double.infinity,
                flex: 1,
                child: Visibility(
                  visible: visible,
                  replacement: const Align(
                    alignment: Alignment(0.0, 0.0),
                    child: CircularProgressIndicator(),
                  ),
                  child: DataBuilder<List<CountriesModel>>(
                    builder: (context, data) => GridView.custom(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 15.0,
                            crossAxisSpacing: 15.0,
                            childAspectRatio: 1.1,
                          ),
                      childrenDelegate: SliverChildBuilderDelegate((
                        context,
                        index,
                      ) {
                        final CountriesModel element = data[index];
                        return GestureDetector(
                          trackpadScrollToScaleFactor: const Offset(0.0, 0.0),
                          onTap: () {
                            if (selectedCountries!.any(
                              (dest) => dest.country_id?.id == element.id,
                            )) {
                              selectedCountries?.removeWhere(
                                (dest) => dest.country_id?.id == element.id,
                              );
                            } else {
                              selectedCountries?.add(
                                CompatibilityDestinationsModel(
                                  country_id: element,
                                ),
                              );
                            }
                            setState(() {});
                          },
                          child: Material(
                            color:
                                (selectedCountries!.any(
                                  (dest) => dest.country_id?.id == element.id,
                                ))
                                ? Theme.of(context).colorScheme.inversePrimary
                                : Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainer,
                            elevation: 5.0,
                            shadowColor: Theme.of(context).colorScheme.shadow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              side: BorderSide(
                                color: Theme.of(
                                  context,
                                ).colorScheme.inversePrimary,
                                width: 2.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 16.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 10.0,
                                children: [
                                  FlexSizedBox(
                                    width: double.infinity,
                                    flex: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: SvgPicture(
                                        SvgNetworkLoader(element.flag_url!),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    element.name!,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
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
                    future: SupabaseService().getAllCountries(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          GlobalState.of(context).localizations.favoriteCountries,
          style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        scrolledUnderElevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          final bool enabled = (selectedCountries?.length == 10);
          return ElevatedButton(
            onPressed: (enabled)
                ? () async {
                    await SupabaseService().deleteCompatibility_destinations();
                    selectedCountries?.forEach((element) {
                      SupabaseService().createCompatibility_destinations(
                        CompatibilityDestinationsModel(
                          country_id: element.country_id,
                        ),
                      );
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            const CompatibilityQuestionsPage(),
                      ),
                    );
                  }
                : null,
            style: ButtonStyle(
              shape: const WidgetStatePropertyAll<RoundedRectangleBorder?>(
                RoundedRectangleBorder(),
              ),
              backgroundColor: WidgetStatePropertyAll<Color?>(
                enabled
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.surfaceContainer,
              ),
              foregroundColor: WidgetStatePropertyAll<Color?>(
                enabled
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).colorScheme.surfaceDim,
              ),
            ),
            child: Text(
              GlobalState.of(context).localizations.confirm,
              style: const TextStyle(fontSize: 28.0, height: 2.0),
            ),
          );
        },
      ),
    );
  }
}
