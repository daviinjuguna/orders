import 'package:flutter/material.dart';

class ErrorButton extends StatelessWidget {
  const ErrorButton({
    super.key,
    required this.onPressed,
    this.text = "Retry",
  });
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.refresh),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.error,
        foregroundColor: Theme.of(context).colorScheme.onError,
      ),
    );
  }
}
