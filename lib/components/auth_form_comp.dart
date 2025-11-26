import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated({'auto-width': 200.0, 'auto-height': 150.0})
class AuthFormComp extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const AuthFormComp({
    this.nom = 'Login',
    this.buttonName = 'Sign in',
    this.icon = Icons.login_rounded,
    this.submitForm,
    this.textFields = const [],
    super.key,
  });

  final String nom;

  final String buttonName;

  final IconData? icon;

  final void Function()? submitForm;

  final List<Widget> textFields;

  @override
  State<AuthFormComp> createState() {
    return _AuthFormCompState();
  }
}

@NowaGenerated()
class _AuthFormCompState extends State<AuthFormComp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
                  bottom: 0.0,
                  left: 0.0,
                  right: 12.0,
                ),
                child: Icon(
                  widget.icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32.0,
                ),
              ),
              Text(
                widget.nom,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 28.0,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
          FlexSizedBox(
            width: double.infinity,
            flex: 1,
            child: ListView(
              reverse: false,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 0.0,
              ),
              children: widget.textFields,
            ),
          ),
          FlexSizedBox(
            width: null,
            height: 48.0,
            child: ElevatedButton(
              onPressed: _handleSubmit,
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color?>(
                  Theme.of(context).colorScheme.primary,
                ),
                foregroundColor: WidgetStatePropertyAll<Color?>(
                  Theme.of(context).colorScheme.onPrimary,
                ),
                shadowColor: WidgetStatePropertyAll<Color?>(
                  Theme.of(context).colorScheme.shadow,
                ),
                elevation: const WidgetStatePropertyAll<double?>(4.0),
                shape: WidgetStatePropertyAll<RoundedRectangleBorder?>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0.0,
                      bottom: 0.0,
                      left: 8.0,
                      right: 0.0,
                    ),
                    child: Text(
                      widget.buttonName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      if (widget.submitForm != null) {
        widget.submitForm?.call();
      }
    }
  }
}
