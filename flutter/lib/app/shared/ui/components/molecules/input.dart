import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blockin/theme/constants/input.dart';
import 'package:blockin/theme/theme.dart';
import 'package:blockin/theme/colors/app_colors.dart';
import 'package:blockin/app/shared/ui/components/atoms/typography.dart';
import 'package:blockin/theme/typography.dart';

class _VariantConfig {
  final bool filled;
  final double borderWidth;
  final double focusedBorderWidth;
  final Color Function(IAppColors, bool, _InputColorScheme, BlockinInputColor)
  fillColorFn;
  final Color Function(IAppColors, bool, _InputColorScheme) borderColorFn;
  final Color Function(IAppColors, bool, _InputColorScheme)
  focusedBorderColorFn;

  const _VariantConfig({
    required this.filled,
    required this.borderWidth,
    required this.focusedBorderWidth,
    required this.fillColorFn,
    required this.borderColorFn,
    required this.focusedBorderColorFn,
  });
}

/// A primitive single-line text input that maps Blockin Input to Flutter Material 3.
///
/// Notes:
/// - Labels, descriptions, and error messaging composition belong to TextField (higher-level).
/// - This component focuses on the input control, start/end adornments, clear button, and variants.
/// - Supports Flutter Form integration via validator and onSaved callbacks.
class BlockinInput extends StatelessWidget {
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
    this.placeholder,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.validator,
    this.onSaved,
    this.autovalidateMode,
    this.variant = BlockinInputVariant.flat,
    this.color = BlockinInputColor.defaultColor,
    this.size = BlockinInputSizeType.medium,
    this.radius = BlockinInputRadiusType.medium,
    this.fullWidth = true,
    this.isClearable = false,
    this.startContent,
    this.endContent,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.hintStyle,
    this.textStyle,
    this.contentPadding,
    this.label,
    this.description,
    this.errorText,
    this.isInvalid = false,
    this.isRequired = false,
    this.showHelper = true,
    this.labelPlacement = BlockinInputLabelPlacement.inside,
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

  /// Placeholder text (maps to Material hintText)
  final String? placeholder;

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
  final BlockinInputVariant variant;
  final BlockinInputColor color;
  final BlockinInputSizeType size;
  final BlockinInputRadiusType radius;
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
  final String? label;
  final String? description;
  final String? errorText;
  final bool isInvalid;
  final bool isRequired;
  final bool showHelper;
  final BlockinInputLabelPlacement labelPlacement;

  @override
  Widget build(BuildContext context) {
    if (validator != null || onSaved != null) {
      return FormField<String>(
        key: key,
        validator: validator,
        onSaved: onSaved,
        autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
        initialValue: controller?.text,
        builder: (field) =>
            _buildInputWithHelper(context, field.errorText, field),
      );
    }
    return _buildInputWithHelper(context, null, null);
  }

  Widget _buildInputWithHelper(
    BuildContext context,
    String? validatorError,
    FormFieldState<String>? formFieldState,
  ) {
    final colors = Theme.of(context).colors;
    final sizeCfg = BlockinInputSize.getConfig(size);
    final borderRadius = BorderRadius.circular(
      BlockinInputRadius.getRadius(radius),
    );
    final useInsideLabel =
        label != null && labelPlacement == BlockinInputLabelPlacement.inside;
    final isUnderlined = variant == BlockinInputVariant.underlined;
    final effectiveHeight = useInsideLabel
        ? sizeCfg.heightWithLabelInside + (isUnderlined ? 4.0 : 0.0)
        : sizeCfg.height;
    final effectiveError = validatorError ?? errorText;
    final effectiveInvalid = validatorError != null || isInvalid;

    Widget inputWidget = _buildInputField(
      context,
      colors,
      sizeCfg,
      borderRadius,
      useInsideLabel,
      validatorError,
      formFieldState,
    );
    if (fullWidth) {
      inputWidget = SizedBox(width: double.infinity, child: inputWidget);
    }
    if (isUnderlined) {
      inputWidget = _AnimatedUnderlineInput(
        focusNode: focusNode,
        color: _resolveTint(
          _InputColorScheme.fromColorSystem(
            effectiveInvalid ? BlockinInputColor.danger : color,
            colors,
          ),
          colors,
        ),
        child: inputWidget,
      );
    }

    final input = ClipRect(
      child: Container(
        height: effectiveHeight,
        width: fullWidth ? double.infinity : null,
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(height: effectiveHeight),
          child: inputWidget,
        ),
      ),
    );

    final labelWidget = _buildLabel(context, colors, sizeCfg, effectiveInvalid);
    final helperWidget = _buildHelper(context, colors, effectiveError);

    Widget wrapHelper(Widget widget) => helperWidget == null
        ? widget
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget,
              const SizedBox(height: 0),
              Transform.translate(
                offset: Offset(0, isUnderlined ? -18.0 : 0.0),
                child: helperWidget,
              ),
            ],
          );

    switch (labelPlacement) {
      case BlockinInputLabelPlacement.inside:
        return wrapHelper(input);
      case BlockinInputLabelPlacement.outside:
      case BlockinInputLabelPlacement.outsideTop:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (labelWidget != null) ...[
              labelWidget,
              const SizedBox(height: 8),
            ],
            wrapHelper(input),
          ],
        );
      case BlockinInputLabelPlacement.outsideLeft:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (labelWidget != null) ...[
              SizedBox(
                height: effectiveHeight,
                child: Center(child: labelWidget),
              ),
              const SizedBox(width: 8),
            ],
            Expanded(child: wrapHelper(input)),
          ],
        );
    }
  }

  TextStyle _getTextStyle(BuildContext context) {
    final typography = BlockinTypographyExtension.of(Theme.of(context));
    final baseStyle = size == BlockinInputSizeType.large
        ? typography.bodyMedium
        : typography.bodySmall;
    return (textStyle ?? const TextStyle()).merge(baseStyle);
  }

  TextStyle _getHintStyle(BuildContext context, Color placeholderColor) {
    final typography = BlockinTypographyExtension.of(Theme.of(context));
    final baseStyle = size == BlockinInputSizeType.large
        ? typography.bodyMedium
        : typography.bodySmall;
    return hintStyle?.copyWith(color: placeholderColor) ??
        baseStyle.copyWith(color: placeholderColor);
  }

  Widget _buildInputField(
    BuildContext context,
    IAppColors colors,
    InputSizeConfig sizeCfg,
    BorderRadius borderRadius,
    bool useInsideLabel,
    String? validatorError,
    FormFieldState<String>? formFieldState,
  ) {
    final decoration = _buildDecoration(
      context,
      colors,
      sizeCfg,
      borderRadius,
      useInsideLabel,
      validatorError,
      formFieldState,
    );
    final textStyle = _getTextStyle(context);

    if (formFieldState != null) {
      return TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        readOnly: readOnly,
        enabled: enabled,
        autofocus: autofocus,
        decoration: decoration,
        style: textStyle,
        onChanged: (value) {
          formFieldState.didChange(value);
          onChanged?.call(value);
        },
        onSaved: null,
        validator: null,
        autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
        onFieldSubmitted: onSubmitted,
        onEditingComplete: onEditingComplete,
        onTap: onTap,
      );
    }

    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      autofocus: autofocus,
      decoration: decoration,
      style: textStyle,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      onTap: onTap,
    );
  }

  static final _variantConfigs = {
    BlockinInputVariant.flat: _VariantConfig(
      filled: true,
      borderWidth: 0,
      focusedBorderWidth: 0,
      fillColorFn: (colors, isInvalid, colorScheme, inputColor) {
        if (isInvalid) return colors.danger.shade100;
        return inputColor == BlockinInputColor.defaultColor
            ? colors.defaultColor.shade100
            : colorScheme.base.shade100;
      },
      borderColorFn: (_, __, ___) => Colors.transparent,
      focusedBorderColorFn: (_, __, ___) => Colors.transparent,
    ),
    BlockinInputVariant.faded: _VariantConfig(
      filled: true,
      borderWidth: 1,
      focusedBorderWidth: 1.5,
      fillColorFn: (colors, isInvalid, _, __) =>
          isInvalid ? colors.danger.shade100 : colors.defaultColor.shade100,
      borderColorFn: (colors, isInvalid, _) =>
          isInvalid ? colors.danger.shade400 : colors.defaultColor.shade200,
      focusedBorderColorFn: (colors, isInvalid, colorScheme) =>
          isInvalid ? colors.danger.shade400 : colorScheme.base.shade400,
    ),
    BlockinInputVariant.bordered: _VariantConfig(
      filled: false,
      borderWidth: 1,
      focusedBorderWidth: 2,
      fillColorFn: (_, __, ___, ____) => Colors.transparent,
      borderColorFn: (colors, isInvalid, _) =>
          isInvalid ? colors.danger.shade400 : colors.defaultColor.shade200,
      focusedBorderColorFn: (colors, isInvalid, colorScheme) =>
          isInvalid ? colors.danger.shade400 : colorScheme.base.shade400,
    ),
    BlockinInputVariant.underlined: _VariantConfig(
      filled: false,
      borderWidth: 0,
      focusedBorderWidth: 0,
      fillColorFn: (_, __, ___, ____) => Colors.transparent,
      borderColorFn: (_, __, ___) => Colors.transparent,
      focusedBorderColorFn: (_, __, ___) => Colors.transparent,
    ),
  };

  EdgeInsetsGeometry _calculateContentPadding(
    InputSizeConfig sizeCfg,
    bool useInsideLabel,
  ) {
    if (contentPadding != null) return contentPadding!;
    if (useInsideLabel) {
      final isUnderlined = variant == BlockinInputVariant.underlined;
      final vertical = size == BlockinInputSizeType.small
          ? ((variant == BlockinInputVariant.bordered ||
                    variant == BlockinInputVariant.faded)
                ? 4.0
                : 6.0)
          : 10.0;
      final horizontal = isUnderlined
          ? 0.0
          : (size == BlockinInputSizeType.small ? 12.0 : sizeCfg.paddingX);
      final offset = isUnderlined ? -6.0 : 6.0;
      return EdgeInsets.only(
        left: horizontal,
        right: horizontal,
        top: vertical + offset,
        bottom: vertical + offset,
      );
    }
    if (variant == BlockinInputVariant.underlined) {
      return const EdgeInsets.only(top: 4.0);
    }
    final verticalPadding = ((sizeCfg.height - sizeCfg.fontSize - 4.0) / 2)
        .clamp(0.0, double.infinity);
    return EdgeInsets.symmetric(
      horizontal: sizeCfg.paddingX,
      vertical: verticalPadding,
    );
  }

  (BoxConstraints, BoxConstraints) _buildIconConstraints(
    InputSizeConfig sizeCfg,
    bool useInsideLabel,
  ) {
    final effectiveHeight = useInsideLabel
        ? sizeCfg.heightWithLabelInside +
              (variant == BlockinInputVariant.underlined ? 4.0 : 0.0)
        : sizeCfg.height;
    return (
      prefixIconConstraints ??
          BoxConstraints(
            minWidth: 0,
            maxWidth: double.infinity,
            minHeight: 0,
            maxHeight: effectiveHeight,
          ),
      suffixIconConstraints ??
          BoxConstraints(
            minWidth: 48.0,
            maxWidth: double.infinity,
            minHeight: 0,
            maxHeight: effectiveHeight,
          ),
    );
  }

  InputDecoration _buildDecoration(
    BuildContext context,
    IAppColors colors,
    InputSizeConfig sizeCfg,
    BorderRadius borderRadius,
    bool useInsideLabel,
    String? validatorError,
    FormFieldState<String>? formFieldState,
  ) {
    final typography = BlockinTypographyExtension.of(Theme.of(context));
    final variantConfig = _variantConfigs[variant]!;
    final isFieldInvalid = validatorError != null || isInvalid;
    final colorScheme = _InputColorScheme.fromColorSystem(
      isFieldInvalid ? BlockinInputColor.danger : color,
      colors,
    );
    final (finalPrefixIconConstraints, finalSuffixIconConstraints) =
        _buildIconConstraints(sizeCfg, useInsideLabel);
    final isUnderlined = variant == BlockinInputVariant.underlined;
    final prefix = startContent != null
        ? Padding(
            padding: EdgeInsets.only(
              left: isUnderlined ? 0.0 : sizeCfg.paddingX,
              right: sizeCfg.gap / 2,
            ),
            child: isFieldInvalid
                ? _applyIconColor(startContent!, colors.danger)
                : startContent,
          )
        : null;
    final suffix = _buildSuffix(
      context,
      colors,
      sizeCfg,
      isFieldInvalid,
      formFieldState,
    );
    final placeholderColor = color == BlockinInputColor.defaultColor
        ? colors.foreground.shade500
        : colorScheme.base.shade500;
    final borderColor = variantConfig.borderColorFn(
      colors,
      isFieldInvalid,
      colorScheme,
    );
    final focusedBorderColor = variantConfig.focusedBorderColorFn(
      colors,
      isFieldInvalid,
      colorScheme,
    );
    final fillColor = variantConfig.filled
        ? variantConfig.fillColorFn(colors, isFieldInvalid, colorScheme, color)
        : null;
    final transparentBorderSide = const BorderSide(
      color: Colors.transparent,
      width: 0,
    );
    final borderSide = BorderSide(
      color: borderColor,
      width: variantConfig.borderWidth,
    );
    final focusedBorderSide = BorderSide(
      color: focusedBorderColor,
      width: variantConfig.focusedBorderWidth,
    );

    InputBorder createBorder(BorderSide side) {
      if (isUnderlined) return UnderlineInputBorder(borderSide: side);
      return (useInsideLabel && !isUnderlined)
          ? _UnderlinedOutlineBorder(
              borderRadius: borderRadius,
              borderSide: side,
            )
          : OutlineInputBorder(borderRadius: borderRadius, borderSide: side);
    }

    return InputDecoration(
      hintText: placeholder,
      hintStyle: _getHintStyle(context, placeholderColor),
      isDense: true,
      filled: variantConfig.filled,
      fillColor: fillColor,
      contentPadding: _calculateContentPadding(sizeCfg, useInsideLabel),
      labelText: useInsideLabel ? (isRequired ? '${label!} *' : label!) : null,
      labelStyle: useInsideLabel
          ? (size == BlockinInputSizeType.large
                    ? typography.bodyMedium
                    : typography.bodySmall)
                .copyWith(color: isFieldInvalid ? colors.danger : null)
          : null,
      floatingLabelBehavior: useInsideLabel && placeholder != null
          ? FloatingLabelBehavior.always
          : null,
      prefixIcon: prefix,
      prefixIconConstraints: finalPrefixIconConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: finalSuffixIconConstraints,
      border: createBorder(
        variantConfig.borderWidth == 0 ? transparentBorderSide : borderSide,
      ),
      enabledBorder: createBorder(
        variantConfig.borderWidth == 0 ? transparentBorderSide : borderSide,
      ),
      focusedBorder: createBorder(
        variantConfig.focusedBorderWidth == 0
            ? transparentBorderSide
            : focusedBorderSide,
      ),
    );
  }

  Widget? _buildLabel(
    BuildContext context,
    IAppColors colors,
    InputSizeConfig sizeCfg,
    bool effectiveInvalid,
  ) {
    if (label == null || labelPlacement == BlockinInputLabelPlacement.inside) {
      return null;
    }
    final textVariant = sizeCfg.outsideLabelFontSize <= 12
        ? BlockinTextVariant.caption
        : BlockinTextVariant.labelSmall;
    final labelColor = effectiveInvalid ? colors.danger : colors.foreground;
    const labelStyle = TextStyle(fontWeight: FontWeight.w500);
    if (!isRequired) {
      return BlockinText(
        label!,
        variant: textVariant,
        color: labelColor,
        style: labelStyle,
      );
    }
    return BlockinRichText(
      variant: textVariant,
      children: [
        BlockinTextSpan(
          text: label!,
          variant: textVariant,
          color: labelColor,
          style: labelStyle,
        ),
        BlockinTextSpan(
          text: ' ',
          variant: textVariant,
          color: labelColor,
          style: labelStyle,
        ),
        BlockinTextSpan(
          text: '*',
          variant: textVariant,
          color: colors.danger,
          style: labelStyle,
        ),
      ],
    );
  }

  Widget? _buildHelper(
    BuildContext context,
    IAppColors colors,
    String? effectiveError,
  ) {
    if (!showHelper ||
        ((effectiveError?.isEmpty ?? true) && (description?.isEmpty ?? true))) {
      return null;
    }
    if (effectiveError?.isNotEmpty ?? false) {
      return BlockinText(
        effectiveError!,
        variant: BlockinTextVariant.caption,
        color: colors.danger,
      );
    }
    return BlockinText(
      description!,
      variant: BlockinTextVariant.caption,
      color: colors.foreground.shade400,
    );
  }

  Widget? _buildSuffix(
    BuildContext context,
    IAppColors colors,
    InputSizeConfig sizeCfg,
    bool effectiveInvalid,
    FormFieldState<String>? formFieldState,
  ) {
    final clear = isClearable && controller != null
        ? IconButton(
            onPressed: () {
              controller!.clear();
              onChanged?.call('');
              formFieldState?.didChange('');
              focusNode?.requestFocus();
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
                clearContent ??
                Icon(
                  Icons.close,
                  color: effectiveInvalid ? colors.danger : null,
                ),
            splashRadius: sizeCfg.fontSize + 4,
            tooltip: 'Clear input',
          )
        : null;
    final endWidget = endContent != null && effectiveInvalid
        ? _applyIconColor(endContent!, colors.danger)
        : endContent;
    if (endWidget == null && clear == null) return null;
    if (endWidget != null && clear == null) return endWidget;
    if (clear != null && endWidget == null) return clear;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [if (endWidget != null) endWidget, if (clear != null) clear],
    );
  }

  Widget _applyIconColor(Widget widget, MaterialColor dangerColor) {
    if (widget is Icon) {
      return Icon(
        widget.icon,
        color: dangerColor,
        size: widget.size,
        semanticLabel: widget.semanticLabel,
        textDirection: widget.textDirection,
      );
    }
    return ColorFiltered(
      colorFilter: ColorFilter.mode(dangerColor, BlendMode.srcIn),
      child: widget,
    );
  }
}

/// Internal color mapping for Input that uses Blockin semantic colors.
class _InputColorScheme {
  const _InputColorScheme({required this.base});

  final MaterialColor base;

  factory _InputColorScheme.fromColorSystem(
    BlockinInputColor color,
    IAppColors colors,
  ) {
    final mapped = switch (color) {
      BlockinInputColor.defaultColor => colors.defaultColor,
      BlockinInputColor.primary => colors.primary,
      BlockinInputColor.secondary => colors.secondary,
      BlockinInputColor.success => colors.success,
      BlockinInputColor.warning => colors.warning,
      BlockinInputColor.danger => colors.danger,
    };
    return _InputColorScheme(base: mapped);
  }
}

Color _resolveTint(_InputColorScheme scheme, IAppColors colors) =>
    scheme.base.shade500;

/// Animated underline widget that expands from center to sides when focused
class _AnimatedUnderlineInput extends StatefulWidget {
  const _AnimatedUnderlineInput({
    required this.focusNode,
    required this.color,
    required this.child,
  });

  final FocusNode? focusNode;
  final Color color;
  final Widget child;

  @override
  State<_AnimatedUnderlineInput> createState() =>
      _AnimatedUnderlineInputState();
}

class _AnimatedUnderlineInputState extends State<_AnimatedUnderlineInput>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  FocusNode? _internalFocusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _internalFocusNode = widget.focusNode;
    if (_internalFocusNode != null) {
      _internalFocusNode!.addListener(_handleFocusChange);
      _isFocused = _internalFocusNode!.hasFocus;
      if (_isFocused) _controller.forward();
    } else {
      FocusManager.instance.addListener(_handleGlobalFocusChange);
      _checkFocus();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_internalFocusNode == null) _checkFocus();
  }

  @override
  void didUpdateWidget(_AnimatedUnderlineInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChange);
      if (_internalFocusNode == null) {
        FocusManager.instance.removeListener(_handleGlobalFocusChange);
      }
      _internalFocusNode = widget.focusNode;
      if (_internalFocusNode != null) {
        _internalFocusNode!.addListener(_handleFocusChange);
        _isFocused = _internalFocusNode!.hasFocus;
        _isFocused ? _controller.forward() : _controller.reverse();
      } else {
        FocusManager.instance.addListener(_handleGlobalFocusChange);
        _checkFocus();
      }
    }
  }

  @override
  void dispose() {
    _internalFocusNode?.removeListener(_handleFocusChange);
    if (_internalFocusNode == null) {
      FocusManager.instance.removeListener(_handleGlobalFocusChange);
    }
    _controller.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    final isFocused = _internalFocusNode?.hasFocus ?? false;
    if (isFocused != _isFocused) {
      setState(() => _isFocused = isFocused);
      isFocused ? _controller.forward() : _controller.reverse();
    }
  }

  void _handleGlobalFocusChange() {
    if (_internalFocusNode == null) _checkFocus();
  }

  void _checkFocus() {
    if (_internalFocusNode != null) return;
    final primaryFocus = FocusManager.instance.primaryFocus;
    if (primaryFocus == null) {
      if (_isFocused) {
        setState(() => _isFocused = false);
        _controller.reverse();
      }
      return;
    }
    final focusedContext = primaryFocus.context;
    final ourContext = context;
    if (focusedContext != null) {
      bool isWithinOurTree = false;
      focusedContext.visitAncestorElements((element) {
        if (element == ourContext.findAncestorStateOfType<State>()?.context ||
            element.findRenderObject() == ourContext.findRenderObject()) {
          isWithinOurTree = true;
          return false;
        }
        return true;
      });
      if (isWithinOurTree != _isFocused) {
        setState(() => _isFocused = isWithinOurTree);
        isWithinOurTree ? _controller.forward() : _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        widget.child,
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          height: 2,
          child: LayoutBuilder(
            builder: (context, constraints) => AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                if (_animation.value == 0) return const SizedBox.shrink();
                final widgetWidth = constraints.maxWidth;
                final centerX = widgetWidth / 2;
                final halfWidth = (_animation.value * widgetWidth) / 2;
                return CustomPaint(
                  size: Size(widgetWidth, 2),
                  painter: _UnderlinePainter(
                    color: widget.color,
                    startX: centerX - halfWidth,
                    endX: centerX + halfWidth,
                    width: 2,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// Custom painter for animated underline that expands from center
class _UnderlinePainter extends CustomPainter {
  const _UnderlinePainter({
    required this.color,
    required this.startX,
    required this.endX,
    required this.width,
  });

  final Color color;
  final double startX;
  final double endX;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(startX.clamp(0, size.width), size.height - width / 2),
      Offset(endX.clamp(0, size.width), size.height - width / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(_UnderlinePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.startX != startX ||
      oldDelegate.endX != endX ||
      oldDelegate.width != width;
}

/// Custom InputBorder that wraps OutlineInputBorder but uses UnderlineInputBorder
/// animation behavior for floating labels. This allows outline variants to have
/// the animated underline effect when labels are placed inside.
class _UnderlinedOutlineBorder extends InputBorder {
  const _UnderlinedOutlineBorder({
    required this.borderRadius,
    required this.borderSide,
  });

  final BorderRadius borderRadius;
  final BorderSide borderSide;

  @override
  _UnderlinedOutlineBorder copyWith({
    BorderSide? borderSide,
    BorderRadius? borderRadius,
  }) {
    return _UnderlinedOutlineBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderSide.width);

  @override
  bool get isOutline => false; // Use underline animation style for label

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(
      borderRadius
          .resolve(textDirection)
          .toRRect(rect)
          .deflate(borderSide.width),
    );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final paint = borderSide.toPaint();
    final rrect = borderRadius.resolve(textDirection).toRRect(rect);
    canvas.drawRRect(rrect, paint);
  }

  @override
  ShapeBorder scale(double t) => _UnderlinedOutlineBorder(
    borderSide: borderSide.scale(t),
    borderRadius: borderRadius * t,
  );
}
