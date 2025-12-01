import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:flutter_svg/flutter_svg.dart';

@NowaGenerated({'auto-width': 330.0, 'auto-height': 107.0})
class PlaceSearchCard extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const PlaceSearchCard({
    this.flag = '',
    this.title = '',
    this.subtitle = '',
    this.onTap,
    super.key,
  });

  final String flag;

  final String title;

  final String subtitle;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18.0),
      onTap: onTap,
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: Theme.of(context).colorScheme.surfaceContainer,
        shadowColor: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 24.0),
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
                  child: SvgPicture(SvgNetworkLoader(flag), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
  }
}
