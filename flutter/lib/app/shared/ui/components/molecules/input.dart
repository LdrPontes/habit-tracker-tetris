import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blockin/theme/constants/input.dart';
import 'package:blockin/theme/theme.dart';
import 'package:blockin/theme/colors/app_colors.dart';
import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/theme/typography.dart';

/// A primitive single-line text input that maps Blockin Input to Flutter Material 3.
///
/// Notes:
/// - Labels, descriptions, and error messaging composition belong to TextFormField (higher-level).
/// - This component focuses on the input control, start/end adornments, clear button.
/// - Supports Flutter Form integration via validator and onSaved callbacks.
/// - Uses UnderlineInputBorder from Flutter Material Design.
/// - Always uses TextFormField internally for consistent behavior.
class BlockinInput extends StatefulWidget {
  const BlockinInput({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.validator,
    this.onSaved,
    this.autovalidateMode,
    this.color = BlockinInputColor.primary,
    this.size = BlockinInputSizeType.large,
    this.fullWidth = true,
    this.isClearable = false,
    this.startContent,
    this.endContent,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.hintStyle,
    this.textStyle,
    this.contentPadding,
    this.hint,
    this.description,
    this.errorText,
    this.isInvalid = false,
    this.showHelper = true,
    this.clearContent,
  });

  /// Controller to manage the input value. Required for clear button to work.
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;

  /// Form validation callback. Returns error message if validation fails, null if valid.
  /// When provided, this enables Form integration and takes precedence over manual errorText.
  final FormFieldValidator<String>? validator;

  /// Callback called when Form.save() is called. Receives the current value.
  final FormFieldSetter<String>? onSaved;

  /// Controls when validation occurs. Only used when validator is provided.
  final AutovalidateMode? autovalidateMode;

  /// Visual props
  final BlockinInputColor color;
  final BlockinInputSizeType size;
  final bool fullWidth;
  final bool isClearable;

  /// Optional start/end adornments
  final Widget? startContent;
  final Widget? endContent;
  final Widget? clearContent;

  /// Optional overrides
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;

  // Labeling & helper
  final String? hint;
  final String? description;
  final String? errorText;
  final bool isInvalid;
  final bool showHelper;

  @override
  State<BlockinInput> createState() => _BlockinInputState();
}

class _BlockinInputState extends State<BlockinInput> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      key: widget.key,
      validator: widget.validator,
      onSaved: widget.onSaved,
      autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.disabled,
      initialValue: widget.controller == null ? '' : null,
      builder: (field) =>
          _buildInputWithHelper(context, field.errorText, field),
    );
  }

  Widget _buildInputWithHelper(
    BuildContext context,
    String? validatorError,
    FormFieldState<String>? formFieldState,
  ) {
    final colors = Theme.of(context).colors;
    final sizeCfg = BlockinInputSize.getConfig(widget.size);
    final effectiveError = validatorError ?? widget.errorText;

    final input = SizedBox(
      height: sizeCfg.height,
      width: widget.fullWidth ? double.infinity : null,
      child: _buildInputField(
        context,
        colors,
        sizeCfg,
        validatorError,
        formFieldState,
      ),
    );

    final helperWidget = _buildHelper(context, colors, effectiveError);

    if (helperWidget == null) {
      return input;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [input, helperWidget],
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    final typography = BlockinTypographyExtension.of(Theme.of(context));
    final baseStyle = widget.size == BlockinInputSizeType.large
        ? typography.bodyMedium
        : typography.bodySmall;
    return (widget.textStyle ?? const TextStyle()).merge(baseStyle);
  }

  TextStyle _getHintStyle(BuildContext context, Color placeholderColor) {
    final typography = BlockinTypographyExtension.of(Theme.of(context));
    final baseStyle = typography.bodySmall;
    return widget.hintStyle?.copyWith(color: placeholderColor) ??
        baseStyle.copyWith(color: placeholderColor);
  }

  Widget _buildInputField(
    BuildContext context,
    IAppColors colors,
    InputSizeConfig sizeCfg,
    String? validatorError,
    FormFieldState<String>? formFieldState,
  ) {
    final decoration = _buildDecoration(
      context,
      colors,
      sizeCfg,
      validatorError,
    );
    final textStyle = _getTextStyle(context);

    return TextField(
      controller: widget.controller,
      focusNode: focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.obscureText,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      decoration: decoration,
      style: textStyle,
      onChanged: (value) {
        formFieldState?.didChange(value);
        widget.onChanged?.call(value);
      },
      onEditingComplete: widget.onEditingComplete,
      onTap: widget.onTap,
      onTapOutside: (event) => focusNode.unfocus(),
    );
  }

  (BoxConstraints, BoxConstraints) _buildIconConstraints(
    InputSizeConfig sizeCfg,
    bool hasPrefixIcon,
  ) {
    return (
      widget.prefixIconConstraints ??
          BoxConstraints(
            minWidth: hasPrefixIcon ? sizeCfg.paddingX + sizeCfg.gap + 8.0 : 0,
            maxWidth: double.infinity,
            minHeight: 0,
            maxHeight: sizeCfg.height,
          ),
      widget.suffixIconConstraints ??
          BoxConstraints(
            minWidth: 48.0,
            maxWidth: double.infinity,
            minHeight: 0,
            maxHeight: sizeCfg.height,
          ),
    );
  }

  InputDecoration _buildDecoration(
    BuildContext context,
    IAppColors colors,
    InputSizeConfig sizeCfg,
    String? validatorError,
  ) {
    final isFieldInvalid = validatorError != null || widget.isInvalid;
    final prefix = widget.startContent != null && isFieldInvalid
        ? _applyIconColor(widget.startContent!, colors.danger)
        : widget.startContent;
    final hasPrefixIcon = prefix != null;
    final (finalPrefixIconConstraints, finalSuffixIconConstraints) =
        _buildIconConstraints(sizeCfg, hasPrefixIcon);
    final suffix = _buildSuffix(colors, sizeCfg, isFieldInvalid);
    final placeholderColor = colors.foreground.shade500;

    final borderColor = isFieldInvalid
        ? colors.danger.shade400
        : colors.inputBorder;

    final focusedBorderColor = isFieldInvalid
        ? colors.danger.shade400
        : _getColorScheme(widget.color, colors).shade400;

    final defaultPadding =
        widget.contentPadding ??
        EdgeInsets.symmetric(
          horizontal: sizeCfg.paddingX,
          vertical: sizeCfg.paddingX,
        );

    return InputDecoration(
      hintText: widget.hint,
      hintStyle: _getHintStyle(context, placeholderColor),
      isDense: true,
      prefixIcon: prefix,
      prefixIconConstraints: finalPrefixIconConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: finalSuffixIconConstraints,
      contentPadding: defaultPadding,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: focusedBorderColor),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colors.danger.shade400),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colors.danger.shade400),
      ),
    );
  }

  Widget? _buildHelper(
    BuildContext context,
    IAppColors colors,
    String? effectiveError,
  ) {
    if (!widget.showHelper) return null;

    if (effectiveError?.isNotEmpty ?? false) {
      return BlockinText(
        effectiveError!,
        variant: BlockinTextVariant.caption,
        color: colors.danger,
        style: TextStyle(height: 1.0),
      );
    }

    if (widget.description?.isNotEmpty ?? false) {
      return BlockinText(
        widget.description!,
        variant: BlockinTextVariant.caption,
        color: colors.foreground.shade400,
        style: TextStyle(height: 1.0),
      );
    }

    return null;
  }

  Widget? _buildSuffix(
    IAppColors colors,
    InputSizeConfig sizeCfg,
    bool effectiveInvalid,
  ) {
    final clear = widget.isClearable && widget.controller != null
        ? IconButton(
            onPressed: () {
              widget.controller!.clear();
              widget.onChanged?.call('');
              focusNode.requestFocus();
              HapticFeedback.selectionClick();
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            constraints: BoxConstraints.tightFor(
              width: sizeCfg.fontSize + 4,
              height: sizeCfg.fontSize + 4,
            ),
            padding: EdgeInsets.zero,
            icon:
                widget.clearContent ??
                Icon(
                  Icons.close,
                  color: effectiveInvalid ? colors.danger : null,
                ),
            splashRadius: sizeCfg.fontSize + 4,
            tooltip: 'Clear input',
          )
        : null;
    final endWidget = widget.endContent != null && effectiveInvalid
        ? _applyIconColor(widget.endContent!, colors.danger)
        : widget.endContent;

    final widgets = <Widget>[];
    if (endWidget != null) widgets.add(endWidget);
    if (clear != null) widgets.add(clear);

    if (widgets.isEmpty) return null;
    if (widgets.length == 1) return widgets.first;
    return Row(mainAxisSize: MainAxisSize.min, children: widgets);
  }

  Widget _applyIconColor(Widget widget, MaterialColor color) {
    if (widget is Icon) {
      return Icon(
        widget.icon,
        color: color,
        size: widget.size,
        semanticLabel: widget.semanticLabel,
        textDirection: widget.textDirection,
      );
    }
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      child: widget,
    );
  }

  MaterialColor _getColorScheme(BlockinInputColor color, IAppColors colors) {
    return switch (color) {
      BlockinInputColor.defaultColor => colors.defaultColor,
      BlockinInputColor.primary => colors.primary,
      BlockinInputColor.secondary => colors.secondary,
      BlockinInputColor.success => colors.success,
      BlockinInputColor.warning => colors.warning,
      BlockinInputColor.danger => colors.danger,
    };
  }
}
