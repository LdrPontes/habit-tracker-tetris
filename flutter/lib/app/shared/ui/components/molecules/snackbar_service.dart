import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:toastification/toastification.dart';

class SnackbarService {
  final BuildContext context;

  SnackbarService.of(this.context);

  void success(String message, {bool autoClose = true, VoidCallback? onClose}) {
    final title = BlockinText.bodyMedium(
      message,
      color: Theme.of(context).colors.successReadableColor,
    );
    toastification.show(
      animationDuration: const Duration(milliseconds: 100),
      autoCloseDuration: autoClose ? const Duration(seconds: 3) : null,
      dragToClose: false,
      alignment: Alignment.bottomCenter,
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      primaryColor: Theme.of(context).colors.success,
      showProgressBar: false,
      title: kIsWeb
          ? SelectableRegion(
              focusNode: FocusNode(),
              selectionControls: materialTextSelectionControls,
              child: title,
            )
          : title,
      icon: Icon(
        PhosphorIconsBold.checkCircle,
        color: Theme.of(context).colors.successReadableColor,
      ),
    );
  }

  void info(String message) {
    toastification.show(
      animationDuration: const Duration(milliseconds: 100),
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.bottomCenter,
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      primaryColor: Theme.of(context).colors.content1,
      showProgressBar: false,
      title: BlockinText.bodyMedium(
        message,
        color: Theme.of(context).colors.content1Foreground,
      ),
      icon: Icon(
        PhosphorIconsBold.info,
        color: Theme.of(context).colors.content1Foreground,
      ),
    );
  }

  void error(String message) {
    toastification.show(
      animationDuration: const Duration(milliseconds: 100),
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.bottomCenter,
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      primaryColor: Theme.of(context).colors.danger,
      showProgressBar: false,
      title: BlockinText.bodyMedium(
        message,
        color: Theme.of(context).colors.dangerReadableColor,
      ),
      icon: Icon(
        PhosphorIconsBold.xCircle,
        color: Theme.of(context).colors.dangerReadableColor,
      ),
    );
  }
}
