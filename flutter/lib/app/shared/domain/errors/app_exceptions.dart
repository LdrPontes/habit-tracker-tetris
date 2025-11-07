import 'package:blockin/core/localization/localizations.dart';

abstract interface class AppException implements Exception {
  /// Returns the localized error message for this exception.
  String getLocalizedMessage(AppLocalizations localizations);
}
