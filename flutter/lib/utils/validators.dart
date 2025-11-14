import 'package:blockin/core/localization/localizations.dart';
import 'package:flutter/material.dart';

class Validators {
  Validators._();

  /// Validates an email address.
  /// Returns null if valid, error message if invalid.
  static String? email(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.validation_error_email_required;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return AppLocalizations.of(context)!.validation_error_email_invalid;
    }

    return null;
  }

  /// Validates a password.
  /// Returns null if valid, error message if invalid.
  static String? password(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.validation_error_password_required;
    }

    if (value.length < 6) {
      return AppLocalizations.of(context)!.validation_error_password_min_length;
    }

    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );

    if (!passwordRegex.hasMatch(value)) {
      return AppLocalizations.of(context)!.validation_error_password_invalid;
    }

    return null;
  }
}
