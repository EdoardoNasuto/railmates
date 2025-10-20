import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated({'auto-width': 177.0, 'auto-height': 90.0})
class TextForm extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const TextForm({
    this.label = 'Label',
    this.icon = Icons.email_outlined,
    this.controller,
    this.required = false,
    this.obscure = false,
    this.errorMessage = 'Format invalide',
    this.validators,
    super.key,
  });

  final String label;

  final IconData? icon;

  final TextEditingController? controller;

  final bool required;

  final bool obscure;

  final String errorMessage;

  final List<RegExp>? validators;

  @override
  State<TextForm> createState() {
    return _TextFormState();
  }
}

@NowaGenerated()
class _TextFormState extends State<TextForm> {
  late bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            validator: (value) {
              if (widget.required && (value == null || value.isEmpty)) {
                return 'Ce champ est requis';
              }
              if (value != null &&
                  widget.validators != null &&
                  widget.validators!.isNotEmpty) {
                bool allValid = widget.validators!.every(
                  (regex) => regex.hasMatch(value),
                );
                if (!allValid) {
                  return widget.errorMessage;
                }
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                widget.icon,
                color: Theme.of(context).colorScheme.primary,
              ),
              suffixIcon: widget.obscure
                  ? IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                  : null,
              labelText: widget.label,
              labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 8.0,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              errorStyle: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12.0,
              ),
            ),
            cursorColor: Theme.of(context).colorScheme.primary,
            controller: widget.controller,
            obscureText: _isObscure,
            enabled: true,
            autofocus: false,
          ),
        ],
      ),
    );
  }
}
