import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:blockin/theme/constants/spinner.dart';
import 'package:blockin/theme/theme.dart';
import 'package:blockin/theme/colors/app_colors.dart';

/// A comprehensive Flutter spinner component that replicates the Blockin spinner system.
///
/// The [BlockinSpinner] provides multiple variants for loading states:
/// - **default** → Dual rotating circles (ease + linear spin)
/// - **gradient** → Gradient-filled rotating circle
/// - **wave** → Animated wave dots
/// - **dots** → Blinking dots
/// - **spinner** → Simple spinning bars
/// - **simple** → Minimal spinning circle
///
/// Example:
/// ```dart
/// BlockinSpinner(
///   variant: BlockinSpinnerVariant.defaultVariant,
///   color: BlockinSpinnerColor.primary,
///   size: BlockinSpinnerSizeType.medium,
///   label: 'Loading...',
/// )
/// ```
class BlockinSpinner extends StatelessWidget {
  const BlockinSpinner({
    super.key,
    this.variant,
    this.color,
    this.size,
    this.label,
    this.labelColor,
    this.customColor,
    this.customLabelColor,
    this.semanticLabel,
  });

  final BlockinSpinnerVariant? variant;
  final BlockinSpinnerColor? color;
  final BlockinSpinnerSizeType? size;
  final String? label;
  final BlockinSpinnerLabelColor? labelColor;
  final Color? customColor;
  final Color? customLabelColor;
  final String? semanticLabel;

  static final _colorMap = {
    BlockinSpinnerColor.current: (IAppColors colors) => colors.foreground,
    BlockinSpinnerColor.white: (IAppColors colors) => Colors.white,
    BlockinSpinnerColor.defaultColor: (IAppColors colors) =>
        colors.defaultColor,
    BlockinSpinnerColor.primary: (IAppColors colors) => colors.primary,
    BlockinSpinnerColor.secondary: (IAppColors colors) => colors.secondary,
    BlockinSpinnerColor.success: (IAppColors colors) => colors.success,
    BlockinSpinnerColor.warning: (IAppColors colors) => colors.warning,
    BlockinSpinnerColor.danger: (IAppColors colors) => colors.danger,
  };

  static final _labelColorMap = {
    BlockinSpinnerLabelColor.foreground: (IAppColors colors) =>
        colors.foreground,
    BlockinSpinnerLabelColor.primary: (IAppColors colors) => colors.primary,
    BlockinSpinnerLabelColor.secondary: (IAppColors colors) => colors.secondary,
    BlockinSpinnerLabelColor.success: (IAppColors colors) => colors.success,
    BlockinSpinnerLabelColor.warning: (IAppColors colors) => colors.warning,
    BlockinSpinnerLabelColor.danger: (IAppColors colors) => colors.danger,
  };

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colors;
    final effectiveVariant = variant ?? BlockinSpinnerVariant.defaultVariant;
    final effectiveColor = color ?? BlockinSpinnerColor.primary;
    final effectiveSize = size ?? BlockinSpinnerSizeType.medium;
    final effectiveLabelColor =
        labelColor ?? BlockinSpinnerLabelColor.foreground;

    final sizeConfig = BlockinSpinnerSize.getConfig(
      effectiveSize,
      variant: effectiveVariant,
    );
    final spinnerColor = customColor ?? _colorMap[effectiveColor]!(colors);
    final textColor =
        customLabelColor ?? _labelColorMap[effectiveLabelColor]!(colors);

    return Semantics(
      label: semanticLabel ?? 'Loading',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: sizeConfig.size,
            height: sizeConfig.size,
            child: _SpinnerWidget(
              variant: effectiveVariant,
              sizeConfig: sizeConfig,
              color: spinnerColor,
            ),
          ),
          if (label != null) ...[
            const SizedBox(height: 8),
            Text(
              label!,
              style: TextStyle(
                color: textColor,
                fontSize: sizeConfig.fontSize,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Unified spinner widget that handles all variants
class _SpinnerWidget extends StatefulWidget {
  const _SpinnerWidget({
    required this.variant,
    required this.sizeConfig,
    required this.color,
  });

  final BlockinSpinnerVariant variant;
  final SpinnerSizeConfig sizeConfig;
  final Color color;

  @override
  State<_SpinnerWidget> createState() => _SpinnerWidgetState();
}

class _SpinnerWidgetState extends State<_SpinnerWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  AnimationController? _secondaryController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _getDuration(widget.variant),
    )..repeat();

    if (widget.variant == BlockinSpinnerVariant.defaultVariant) {
      _secondaryController = AnimationController(
        vsync: this,
        duration: BlockinSpinnerAnimation.linearSpin,
      )..repeat();
    }
  }

  Duration _getDuration(BlockinSpinnerVariant variant) {
    return switch (variant) {
      BlockinSpinnerVariant.defaultVariant => BlockinSpinnerAnimation.easeSpin,
      BlockinSpinnerVariant.gradient => BlockinSpinnerAnimation.gradientSpin,
      BlockinSpinnerVariant.wave => const Duration(milliseconds: 800),
      BlockinSpinnerVariant.dots => const Duration(milliseconds: 800),
      BlockinSpinnerVariant.spinner => BlockinSpinnerAnimation.barFadeOut,
      BlockinSpinnerVariant.simple => BlockinSpinnerAnimation.easeSpin,
    };
  }

  @override
  void dispose() {
    _controller.dispose();
    _secondaryController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.variant) {
      BlockinSpinnerVariant.defaultVariant => _buildDefaultSpinner(),
      BlockinSpinnerVariant.gradient => _buildGradientSpinner(),
      BlockinSpinnerVariant.wave => _buildDotsSpinner(true),
      BlockinSpinnerVariant.dots => _buildDotsSpinner(false),
      BlockinSpinnerVariant.spinner => _buildBarsSpinner(),
      BlockinSpinnerVariant.simple => _buildSimpleSpinner(),
    };
  }

  Widget _buildDefaultSpinner() {
    return Stack(
      children: [
        RotationTransition(
          turns: CurveTween(curve: Curves.ease).animate(_controller),
          child: CustomPaint(
            size: Size(widget.sizeConfig.size, widget.sizeConfig.size),
            painter: _ArcPainter(
              color: widget.color,
              borderWidth: widget.sizeConfig.borderWidth,
              startAngle: math.pi / 4,
              sweepAngle: math.pi / 2,
              isDotted: false,
            ),
          ),
        ),
        RotationTransition(
          turns: _secondaryController!,
          child: CustomPaint(
            size: Size(widget.sizeConfig.size, widget.sizeConfig.size),
            painter: _ArcPainter(
              color: widget.color.withOpacity(0.75),
              borderWidth: widget.sizeConfig.borderWidth,
              startAngle: math.pi / 4,
              sweepAngle: math.pi / 2,
              isDotted: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGradientSpinner() {
    return RotationTransition(
      turns: _controller,
      child: CustomPaint(
        size: Size(widget.sizeConfig.size, widget.sizeConfig.size),
        painter: _GradientPainter(color: widget.color),
      ),
    );
  }

  Widget _buildDotsSpinner(bool isWave) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return _AnimatedDot(
          size: widget.sizeConfig.dotSize,
          color: widget.color,
          phaseOffset: isWave ? index / 3.0 : null,
          delay: isWave ? null : Duration(milliseconds: 200 * index),
          isWave: isWave,
        );
      }),
    );
  }

  Widget _buildBarsSpinner() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.sizeConfig.size, widget.sizeConfig.size),
          painter: _BarsPainter(
            color: widget.color,
            progress: _controller.value,
          ),
        );
      },
    );
  }

  Widget _buildSimpleSpinner() {
    return RotationTransition(
      turns: _controller,
      child: Stack(
        children: [
          Container(
            width: widget.sizeConfig.size,
            height: widget.sizeConfig.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.color.withOpacity(0.25),
                width: widget.sizeConfig.borderWidth,
              ),
            ),
          ),
          CustomPaint(
            size: Size(widget.sizeConfig.size, widget.sizeConfig.size),
            painter: _ArcPainter(
              color: widget.color.withOpacity(0.75),
              borderWidth: widget.sizeConfig.borderWidth,
              startAngle: -math.pi / 2,
              sweepAngle: math.pi * 1.5,
              isDotted: false,
            ),
          ),
        ],
      ),
    );
  }
}

/// Unified arc painter for all arc-based spinners
class _ArcPainter extends CustomPainter {
  final Color color;
  final double borderWidth;
  final double startAngle;
  final double sweepAngle;
  final bool isDotted;

  _ArcPainter({
    required this.color,
    required this.borderWidth,
    required this.startAngle,
    required this.sweepAngle,
    required this.isDotted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(radius, radius);
    final arcRadius = radius - borderWidth / 2;

    if (isDotted) {
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      const dotCount = 4;
      final dotRadius = borderWidth / 2;

      for (var i = 0; i < dotCount; i++) {
        final angle = startAngle + (sweepAngle * i / (dotCount - 1));
        final x = center.dx + arcRadius * math.cos(angle);
        final y = center.dy + arcRadius * math.sin(angle);
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    } else {
      final paint = Paint()
        ..color = color
        ..strokeWidth = borderWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: arcRadius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Gradient painter for gradient spinner
class _GradientPainter extends CustomPainter {
  final Color color;

  _GradientPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final gradient = SweepGradient(
      colors: [Colors.transparent, Colors.transparent, color],
      stops: const [0.0, 0.5, 1.0],
    );

    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()..shader = gradient.createShader(rect);

    canvas.saveLayer(rect, Paint());
    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(
      center,
      radius - 3,
      Paint()..blendMode = BlendMode.dstOut,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Animated dot for wave and dots variants
class _AnimatedDot extends StatefulWidget {
  const _AnimatedDot({
    required this.size,
    required this.color,
    this.phaseOffset,
    this.delay,
    required this.isWave,
  });

  final double size;
  final Color color;
  final double? phaseOffset;
  final Duration? delay;
  final bool isWave;

  @override
  State<_AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<_AnimatedDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = widget.isWave
        ? TweenSequence<double>([
            TweenSequenceItem(
              tween: Tween(
                begin: 4.0,
                end: -4.0,
              ).chain(CurveTween(curve: Curves.easeInOut)),
              weight: 1,
            ),
            TweenSequenceItem(
              tween: Tween(
                begin: -4.0,
                end: 4.0,
              ).chain(CurveTween(curve: Curves.easeInOut)),
              weight: 1,
            ),
          ]).animate(_controller)
        : Tween<double>(begin: 0.3, end: 1.0).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          );

    if (widget.phaseOffset != null) {
      _controller.value = widget.phaseOffset!;
      _controller.repeat(reverse: true);
    } else if (widget.delay != null) {
      Future.delayed(widget.delay!, () {
        if (mounted) _controller.repeat(reverse: true);
      });
    } else {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: widget.isWave ? Offset(0, _animation.value) : Offset.zero,
          child: Opacity(
            opacity: widget.isWave ? 1.0 : _animation.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              margin: EdgeInsets.symmetric(horizontal: widget.size * 0.2),
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Painter for rotating bars
class _BarsPainter extends CustomPainter {
  final Color color;
  final double progress;

  _BarsPainter({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const barCount = 12;
    final barWidth = size.width * 0.25;
    final barHeight = size.height * 0.08;

    for (var i = 0; i < barCount; i++) {
      final angle = (i * 30.0) * math.pi / 180;
      final barProgress = (progress + (i / barCount)) % 1.0;
      final opacity = 1.0 - barProgress;

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(-angle);
      canvas.translate(size.width * 0.375, 0);

      final paint = Paint()
        ..color = color.withOpacity(opacity)
        ..style = PaintingStyle.fill;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(-barWidth / 2, -barHeight / 2, barWidth, barHeight),
          Radius.circular(barHeight / 2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_BarsPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
