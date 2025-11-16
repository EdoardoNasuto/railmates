import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated({'auto-width': 159.0, 'auto-height': 67.0})
class TextForm extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const TextForm({
    this.label = 'Label',
    this.icon = Icons.text_fields,
    this.controller,
    this.dateField = false,
    this.required = false,
    this.obscure = false,
    this.onChanged,
    this.onTap,
    this.errorMessage = 'Format invalide',
    this.validators,
    this.interactiveSelection = true,
    super.key,
  });
  final void Function()? onTap;

  final String label;

  final IconData? icon;

  final TextEditingController? controller;

  final bool dateField;

  final bool required;

  final bool obscure;

  final void Function(String value)? onChanged;

  final String errorMessage;

  final List<RegExp>? validators;

  final bool interactiveSelection;

  @override
  State<TextForm> createState() {
    return _TextFormState();
  }
}

@NowaGenerated()
class _TextFormState extends State<TextForm> {
  late bool _isObscure = false;

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
          TextFormField(
            enableInteractiveSelection: widget.interactiveSelection,
            readOnly: widget.dateField || widget.onTap != null,
            onTap: widget.dateField
                ? () async {
                    DateTime defaultInitialDate = DateTime(
                      DateTime.now().year - 16,
                      DateTime.now().month,
                      DateTime.now().day,
                    );
                    DateTime initialDate = defaultInitialDate;
                    if (widget.controller != null &&
                        widget.controller!.text.isNotEmpty) {
                      try {
                        DateTime parsed = DateTime.parse(
                          widget.controller!.text,
                        );
                        initialDate = parsed;
                      } catch (_) {}
                    }
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: DateTime(
                        DateTime.now().year - 100,
                        DateTime.now().month,
                        DateTime.now().day,
                      ),
                      lastDate: DateTime(
                        DateTime.now().year - 16,
                        DateTime.now().month,
                        DateTime.now().day,
                      ),
                    );
                    if (picked != null && widget.controller != null) {
                      widget.controller?.text = picked.toString().split(
                            ' ',
                          )[0];
                      setState(() {});
                    }
                  }
                : widget.onTap,
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
            onChanged: widget.onChanged,
          ),
        ],
      ),
    );
  }
}
