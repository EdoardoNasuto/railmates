import 'package:flutter/material.dart';
import 'package:railmates/models/compatibility_destinations_model.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/models/countries_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

@NowaGenerated()
class CompatibilityCountriesPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityCountriesPage({super.key});

  @override
  State<CompatibilityCountriesPage> createState() {
    return _CompatibilityCountriesPageState();
  }
}

@NowaGenerated()
class _CompatibilityCountriesPageState
    extends State<CompatibilityCountriesPage> {
  List<CompatibilityDestinationsModel>? selectedCountries = [];

  @override
  void initState() {
    super.initState();
    _loadSelectedCountries();
  }

  Future<void> _loadSelectedCountries() async {
    selectedCountries = await SupabaseService()
        .getAllCompatibility_destinations();
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
          minimum: const EdgeInsets.only(
            top: 40.0,
            bottom: 40.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10.0,
            children: [
              FlexSizedBox(
                width: double.infinity,
                height: null,
                child: ListTile(
                  title: Text(
                    'Favorite countries',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: const Text(
                    'Choose 10 countries you would like to visit',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              FlexSizedBox(
                width: double.infinity,
                flex: 1,
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
                            (dest) => dest.country_id == element.id,
                          )) {
                            selectedCountries?.removeWhere(
                              (dest) => dest.country_id == element.id,
                            );
                          } else {
                            if (selectedCountries?.length != 10) {
                              selectedCountries?.add(
                                CompatibilityDestinationsModel(
                                  country_id: element.id,
                                ),
                              );
                            } else {
                              showDialog(
                                builder: (context) => const AlertDialog(
                                  title: Text(
                                    'You can only choose 10 countries',
                                  ),
                                ),
                                useRootNavigator: false,
                                context: context,
                                anchorPoint: const Offset(0.0, 0.0),
                              );
                              return;
                            }
                          }
                          setState(() {});
                        },
                        child: Material(
                          color:
                              (selectedCountries!.any(
                                (dest) => dest.country_id == element.id,
                              ))
                              ? Theme.of(context).colorScheme.inversePrimary
                              : Theme.of(context).colorScheme.surfaceContainer,
                          elevation: 5.0,
                          shadowColor: Theme.of(context).colorScheme.shadow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 8.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 10.0,
                              children: [
                                FlexSizedBox(
                                  child: Container(
                                    width: 70.0,
                                    height: 45.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.grey.shade200,
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: SvgPicture(
                                      SvgNetworkLoader(element.flag_url!),
                                      fit: BoxFit.cover,
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
                      style: const TextStyle(color: Color(0xffff0000)),
                    ),
                  ),
                  future: SupabaseService().getAllCountries(),
                ),
              ),
              FlexSizedBox(
                width: null,
                height: null,
                child: ElevatedButton(
                  onPressed: (selectedCountries?.length == 10)
                      ? () async {
                          await SupabaseService()
                              .deleteCompatibility_destinations();
                          await SupabaseService()
                              .createCompatibility_destinations(
                                selectedCountries!,
                              );
                        }
                      : null,
                  onLongPress: null,
                  child: const Text('Confirm'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
