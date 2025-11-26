import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated({'auto-width': 200.0, 'auto-height': 60.0})
class AuthTextFormFieldComp extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const AuthTextFormFieldComp({
    this.onTap,
    this.label = 'Label',
    this.icon = Icons.text_fields,
    this.controller,
    this.readOnly = false,
    this.required = false,
    this.obscure = false,
    this.errorMessage = 'Invalid format',
    this.regexValidator,
    super.key,
  });

  final void Function()? onTap;

  final String label;

  final IconData? icon;

  final TextEditingController? controller;

  final bool readOnly;

  final bool required;

  final bool obscure;

  final String errorMessage;

  final String? regexValidator;

  @override
  State<AuthTextFormFieldComp> createState() {
    return _AuthTextFormFieldCompState();
  }
}

@NowaGenerated()
class _AuthTextFormFieldCompState extends State<AuthTextFormFieldComp> {
  late bool _isObscure = false;

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscure;
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && widget.controller != null) {
        widget.controller?.text = widget.controller!.text.trim();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            enableInteractiveSelection: !widget.readOnly,
            readOnly: widget.readOnly,
            focusNode: _focusNode,
            onTap: widget.onTap,
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
            validator: (value) {
              if (widget.required && (value == null || value!.isEmpty)) {
                return 'Field is required';
              }
              if (!RegExp(widget.regexValidator!).hasMatch(value!)) {
                return widget.errorMessage;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
