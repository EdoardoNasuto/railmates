import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/models/cities_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:railmates/integrations/supabase_service.dart';

@NowaGenerated({'auto-width': 330.0, 'auto-height': 350.0})
class CityResearch extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CityResearch({this.search = '', super.key});

  final String search;

  @override
  State<CityResearch> createState() {
    return _CityResearchState();
  }
}

@NowaGenerated()
class _CityResearchState extends State<CityResearch> {
  @override
  Widget build(BuildContext context) {
    return DataBuilder<List<CitiesModel>>(
      builder: (context, data) => ListView.separated(
        itemCount: data.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          final CitiesModel element = data[index];
          return InkWell(
            borderRadius: BorderRadius.circular(18.0),
            onTap: () {
              Navigator.of(context).pop<CitiesModel?>(
                CitiesModel(id: element.id, name: element.name),
              );
            },
            child: Card(
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Theme.of(context).colorScheme.surface,
              shadowColor: Theme.of(
                context,
              ).colorScheme.shadow.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 22.0,
                  horizontal: 24.0,
                ),
                child: Row(
                  children: [
                    FlexSizedBox(
                      width: 48.0,
                      height: 48.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(
                                context,
                              ).colorScheme.shadow.withOpacity(0.1),
                              blurRadius: 8.0,
                              offset: const Offset(0.0, 4.0),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: SvgPicture(
                          SvgNetworkLoader(element.country_id!.flag_url!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            element.name!,
                            style:
                                Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold) ??
                                const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            element.state_name!,
                            style:
                                Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.6),
                                ) ??
                                const TextStyle(
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
      future: SupabaseService().getAllCities(widget.search),
    );
  }
}
