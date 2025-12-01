import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/models/cities_model.dart';
import 'package:railmates/components/place_search_card.dart';
import 'package:railmates/integrations/supabase_service.dart';

@NowaGenerated({'auto-width': 330.0, 'auto-height': 350.0})
class CitySearchBuilder extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CitySearchBuilder({this.prefix, super.key});

  final String? prefix;

  @override
  State<CitySearchBuilder> createState() {
    return _CitySearchBuilderState();
  }
}

@NowaGenerated()
class _CitySearchBuilderState extends State<CitySearchBuilder> {
  @override
  Widget build(BuildContext context) {
    return DataBuilder<List<CitiesModel>>(
      builder: (context, data) => ListView.separated(
        itemCount: data.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          final CitiesModel element = data[index];
          return PlaceSearchCard(
            flag: element.country_id!.flag_url!,
            title: element.name!,
            subtitle: element.state_name!,
            onTap: () {
              Navigator.of(context).pop<CitiesModel?>(
                CitiesModel(id: element.id, name: element.name),
              );
            },
          );
        },
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
      future: SupabaseService().getAllCities(widget.prefix!, limit: 5),
    );
  }
}
