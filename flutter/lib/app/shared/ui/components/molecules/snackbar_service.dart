import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:toastification/toastification.dart';

class SnackbarService {
  final BuildContext context;

  SnackbarService.of(this.context);

  void success(String message, {bool autoClose = true, VoidCallback? onClose}) {
    final title = Text(message, style: Theme.of(context).textTheme.bodyMedium);
    toastification.show(
      animationDuration: const Duration(milliseconds: 100),
      autoCloseDuration: autoClose ? const Duration(seconds: 3) : null,
      dragToClose: false,
      alignment: Alignment.bottomCenter,
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      primaryColor: Colors.green.shade500,
      showProgressBar: false,
      title: kIsWeb
          ? SelectableRegion(
              focusNode: FocusNode(),
              selectionControls: materialTextSelectionControls,
              child: title,
            )
          : title,
      icon: Icon(PhosphorIcons.checkCircle(), color: Colors.green.shade500),
    );
  }

  void info(String message) {
    toastification.show(
      animationDuration: const Duration(milliseconds: 100),
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.bottomCenter,
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      primaryColor: Colors.blue.shade500,
      showProgressBar: false,
      title: Text(message, style: Theme.of(context).textTheme.bodyMedium),
      icon: Icon(PhosphorIcons.info(), color: Colors.blue.shade500),
    );
  }

  void error(String message) {
    toastification.show(
      animationDuration: const Duration(milliseconds: 100),
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.bottomCenter,
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      primaryColor: Colors.red.shade500,
      showProgressBar: false,
      title: Text(message, style: Theme.of(context).textTheme.bodyMedium),
      icon: Icon(PhosphorIcons.xCircle(), color: Colors.red.shade500),
    );
  }
}
