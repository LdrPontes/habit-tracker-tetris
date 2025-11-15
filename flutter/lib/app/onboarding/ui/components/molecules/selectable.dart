import 'package:blockin/app/shared/ui/components/molecules/button.dart';
import 'package:blockin/theme/constants/button.dart';
import 'package:blockin/theme/constants/radius.dart';
import 'package:blockin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// A selectable button component that is fully controlled by its parent.
///
/// This component does not manage its own state. The selection state must be
/// controlled by the parent widget (e.g., [BlockinSelectableGroup]).
class BlockinSelectable extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function(bool) onChanged;

  const BlockinSelectable({
    super.key,
    required this.text,
    this.isSelected = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlockinButton(
      onPressed: () {
        // Invert the current selection state and notify parent
        onChanged(!isSelected);
      },
      text: text,
      variant: BlockinButtonVariant.bordered,
      color: isSelected
          ? BlockinButtonColor.primary
          : BlockinButtonColor.defaultColor,
      size: BlockinButtonSizeType.large,
      customForegroundColor: !isSelected
          ? Theme.of(context).colors.foreground.shade900
          : null,
      radius: BlockinRadiusType.full,
      fullWidth: true,
    );
  }
}

@Preview(name: 'BlockinSelectable')
Widget blockinSelectablePreview() {
  return Scaffold(
    backgroundColor: Colors.black,
    body: Theme(
      data: BlockinTheme.darkTheme(),
      child: Center(
        child: BlockinSelectable(
          text: 'Selectable',
          onChanged: (isSelected) {},
        ),
      ),
    ),
  );
}
