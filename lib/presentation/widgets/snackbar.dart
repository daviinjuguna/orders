import 'package:flutter/material.dart';

extension ShowSnackBar on BuildContext {
  void hideSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }

  void loadingSnackbar([Key key = const Key('loading_snackbar')]) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(this).colorScheme.primaryContainer,
          key: key,
          content: Row(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(this).colorScheme.onPrimaryContainer,
                ),
              ),
              const Spacer(),
              Text(
                'Loading...',
                style: TextStyle(
                  color: Theme.of(this).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 60),
          behavior: SnackBarBehavior.fixed,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        ),
      );
  }

  void errorSnackbar([String? message]) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message ?? "Please try again",
            style: TextStyle(color: Theme.of(this).colorScheme.onError),
          ),
          backgroundColor: Theme.of(this).colorScheme.error,
          behavior: SnackBarBehavior.fixed,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        ),
      );
  }
}
