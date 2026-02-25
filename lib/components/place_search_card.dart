import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:flutter_svg/flutter_svg.dart';

@NowaGenerated({'auto-width': 393.0, 'auto-height': 110.0})
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
    return Material(
      elevation: 3.0,
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 24.0),
          child: Row(
            children: [
              FlexSizedBox(
                height: 48.0,
                width: 60.0,
                child: Material(
                  color: Theme.of(context).colorScheme.primary,
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
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
