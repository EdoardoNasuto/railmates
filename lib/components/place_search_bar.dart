import 'package:flutter/material.dart';
import 'dart:async';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated({'auto-width': 393.0, 'auto-height': 53.0})
class PlaceSearchBar extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const PlaceSearchBar({this.controller, this.onChange, super.key});

  final TextEditingController? controller;

  final void Function(String value)? onChange;

  @override
  State<PlaceSearchBar> createState() {
    return _PlaceSearchBarState();
  }
}

@NowaGenerated()
class _PlaceSearchBarState extends State<PlaceSearchBar> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.07),
            blurRadius: 12.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        onChanged: (value) {
          if (!(_debounce?.isActive ?? false)) {
            _debounce = Timer(const Duration(milliseconds: 400), () {
              widget.onChange?.call(value);
            });
          }
        },
        decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18.0,
            horizontal: 10.0,
          ),
          hintText: 'Rechercher une ville',
          border: InputBorder.none,
        ),
        autofocus: true,
      ),
    );
  }
}
