import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:flutter_svg/svg.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/integrations/supabase_enums.dart';

@NowaGenerated({'auto-width': 330.0, 'auto-height': 482.0})
class CityResearch extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CityResearch(
      {this.type = SearchType.cities, this.name = 'pari', super.key});

  final SearchType type;

  final String name;

  @override
  Widget build(BuildContext context) {
    return DataBuilder<List<dynamic>>(
      builder: (context, data) => ListView.separated(
        itemCount: data.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          final dynamic item = data[index];
          final dynamic id = item['id'];
          final dynamic title = item['title'];
          final dynamic subtitle1 =
              (item['subtitle1'] == null) ? '' : item['subtitle1'];
          final dynamic subtitle2 =
              (item['subtitle2'] == null) ? '' : item['subtitle2'];
          final dynamic icon = item['icon'];
          return InkWell(
            borderRadius: BorderRadius.circular(18.0),
            onTap: () {
              Navigator.pop(context, {'id': id, 'name': title});
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
                    Container(
                      width: 48.0,
                      height: 48.0,
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
                      clipBehavior: Clip.antiAlias,
                      child: icon != null && icon is String && icon.isNotEmpty
                          ? Stack(
                              fit: StackFit.expand,
                              children: [
                                icon.endsWith('.svg')
                                    ? SvgPicture.network(
                                        icon,
                                        fit: BoxFit.cover,
                                        width: 48.0,
                                        height: 48.0,
                                        placeholderBuilder: (context) => Center(
                                          child: Icon(
                                            Icons.flag,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimaryFixed,
                                            size: 28.0,
                                          ),
                                        ),
                                      )
                                    : Image.network(
                                        icon,
                                        fit: BoxFit.cover,
                                        width: 48.0,
                                        height: 48.0,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Center(
                                          child: Icon(
                                            Icons.flag,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryFixed,
                                            size: 28.0,
                                          ),
                                        ),
                                      ),
                              ],
                            )
                          : Center(
                              child: Icon(
                                Icons.flag,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryFixed,
                                size: 28.0,
                              ),
                            ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold) ??
                                const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            '${subtitle1}${subtitle2}',
                            style: Theme.of(
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
      future: SupabaseService().citiesStartingWith(name, type: type),
    );
  }
}
