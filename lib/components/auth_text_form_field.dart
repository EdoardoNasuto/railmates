import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated({'auto-width': 200.0, 'auto-height': 60.0})
class AuthTextFormField extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const AuthTextFormField({
    this.icon = Icons.text_fields,
    this.label = 'Label',
    this.controller,
    this.required = false,
    this.obscure = false,
    this.onTap,
    this.errorMessage = 'Invalid format',
    this.regexValidator = '',
    super.key,
  });

  final IconData? icon;

  final String label;

  final TextEditingController? controller;

  final bool required;

  final bool obscure;

  final void Function()? onTap;

  final String errorMessage;

  final String? regexValidator;

  @override
  State<AuthTextFormField> createState() {
    return _AuthTextFormFieldState();
  }
}

@NowaGenerated()
class _AuthTextFormFieldState extends State<AuthTextFormField> {
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
            enableInteractiveSelection: widget.onTap == null ? true : false,
            readOnly: widget.onTap == null ? false : true,
            focusNode: _focusNode,
            onTap: widget.onTap,
            controller: widget.controller,
            obscureText: _isObscure,
            validator: (value) {
              if (widget.required && (value == null || value!.isEmpty)) {
                return 'Field is required';
              }
              if (!RegExp(widget.regexValidator!).hasMatch(value!)) {
                return widget.errorMessage;
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
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainer,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              labelStyle: Theme.of(context).textTheme.labelSmall,
            ),
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
