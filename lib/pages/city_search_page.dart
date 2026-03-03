import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/components/place_search_bar.dart';
import 'package:railmates/global_state.dart';
import 'package:railmates/models/cities_model.dart';
import 'package:railmates/components/place_search_card.dart';
import 'package:go_router/go_router.dart';
import 'package:railmates/integrations/supabase_service.dart';

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
  TextEditingController? searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlexSizedBox(
              width: double.infinity,
              child: PlaceSearchBar(
                controller: searchBarController,
                hint: GlobalState.of(context).localizations.searchCity,
                onChange: (value) {
                  setState(() {});
                },
              ),
            ),
            FlexSizedBox(
              width: double.infinity,
              flex: 1,
              child: DataBuilder<List<CitiesModel>>(
                builder: (context, data) => ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16.0),
                  itemBuilder: (context, index) {
                    final CitiesModel element = data[index];
                    return PlaceSearchCard(
                      flag: element.country_id!.flag_url!,
                      title: element.name!,
                      subtitle: element.state_name!,
                      onTap: () {
                        GoRouter.of(context).pop<CitiesModel?>(
                          CitiesModel(id: element.id, name: element.name),
                        );
                      },
                    );
                  },
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 8.0,
                  ),
                ),
                loadingWidget: Align(
                  alignment: const Alignment(0.0, 0.0),
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                    strokeWidth: 4.0,
                  ),
                ),
                errorBuilder: (context, error) => Align(
                  alignment: const Alignment(0.0, 0.0),
                  child: Text(
                    error.toString(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                future: SupabaseService().getByPrefixCities(
                  searchBarController!.text,
                  limit: 5,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
