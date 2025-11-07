import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/widget_previews.dart';

class BoardPiece extends StatelessWidget {
  final List<List<int>> shape;
  final Color? color;
  final String? svgAssetPath;
  final int rotationDegrees;
  final double cellSize;
  final bool isDragging;

  const BoardPiece({
    super.key,
    required this.shape,
    this.color,
    this.svgAssetPath,
    this.rotationDegrees = 0,
    this.cellSize = 25.0,
    this.isDragging = false,
  }) : assert(
          (color != null && svgAssetPath == null) ||
              (color == null && svgAssetPath != null),
          'Either color or svgAssetPath must be provided, but not both',
        );

  int get width => shape.isNotEmpty ? shape[0].length : 0;
  int get height => shape.length;
  bool get isSvg => svgAssetPath != null;

  @override
  Widget build(BuildContext context) {
    final Color draggingBorderColor = Colors.black.withAlpha(
      (255 * 0.3).toInt(),
    );
    return isSvg
        ? _buildSvg(svgAssetPath!, draggingBorderColor)
        : _buildColor(color!, draggingBorderColor);
  }

  Widget _buildSvg(String svgAssetPath, Color draggingBorderColor) {
    final size = Size(cellSize * width, cellSize * height);
    final svgWidth = rotationDegrees % 180 == 90 ? size.height : size.width;
    final svgHeight = rotationDegrees % 180 == 90 ? size.width : size.height;

    return Stack(
      children: [
        RotatedBox(
          quarterTurns: rotationDegrees ~/ 90,
          child: SvgPicture.asset(
            svgAssetPath,
            width: svgWidth,
            height: svgHeight,
            fit: BoxFit.fill,
          ),
        ),
        if (isDragging)
          CustomPaint(
            size: size,
            painter: PieceBorderPainter(
              shape: shape,
              cellSize: cellSize,
              borderColor: draggingBorderColor,
            ),
          ),
      ],
    );
  }

  Widget _buildColor(Color color, Color draggingBorderColor) {
    return CustomPaint(
      size: Size(width * cellSize, height * cellSize),
      painter: PiecePainter(
        shape: shape,
        cellSize: cellSize,
        isDragging: isDragging,
        borderColor: draggingBorderColor,
        color: color,
      ),
    );
  }
}

class PiecePainter extends CustomPainter {
  final List<List<int>> shape;
  final double cellSize;
  final bool isDragging;
  final Color borderColor;
  final Color color;
  
  PiecePainter({
    required this.shape,
    required this.cellSize,
    required this.borderColor,
    required this.color,
    this.isDragging = false,
  });

  int get width => shape.isNotEmpty ? shape[0].length : 0;
  int get height => shape.length;

  @override
  void paint(Canvas canvas, Size size) {
    final cellPaint = Paint()..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white.withValues(alpha: 255 * 0.3)
      ..strokeWidth = 1;

    final draggingBorderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = borderColor
      ..strokeWidth = 2;

    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        if (shape[row][col] == 1) {
          final x = col * cellSize;
          final y = row * cellSize;

          cellPaint.color = color;

          // Draw cell
          canvas.drawRect(Rect.fromLTWH(x, y, cellSize, cellSize), cellPaint);

          // Draw border
          canvas.drawRect(Rect.fromLTWH(x, y, cellSize, cellSize), borderPaint);

          // Draw dragging border if needed
          if (isDragging) {
            _drawCellOutline(canvas, x, y, row, col, draggingBorderPaint);
          }
        }
      }
    }
  }

  void _drawCellOutline(
    Canvas canvas,
    double x,
    double y,
    int row,
    int col,
    Paint paint,
  ) {
    final borderWidth = paint.strokeWidth;
    final fillPaint = Paint()
      ..color = paint.color
      ..style = PaintingStyle.fill;

    // Draw top edge if there's no cell above or if it's the top edge of the shape
    if (row == 0 || shape[row - 1][col] == 0) {
      canvas.drawRect(Rect.fromLTWH(x, y, cellSize, borderWidth), fillPaint);
    }

    // Draw bottom edge if there's no cell below or if it's the bottom edge of the shape
    if (row == height - 1 || shape[row + 1][col] == 0) {
      canvas.drawRect(
        Rect.fromLTWH(x, y + cellSize - borderWidth, cellSize, borderWidth),
        fillPaint,
      );
    }

    // Draw left edge if there's no cell to the left or if it's the left edge of the shape
    if (col == 0 || shape[row][col - 1] == 0) {
      canvas.drawRect(Rect.fromLTWH(x, y, borderWidth, cellSize), fillPaint);
    }

    // Draw right edge if there's no cell to the right or if it's the right edge of the shape
    if (col == width - 1 || shape[row][col + 1] == 0) {
      canvas.drawRect(
        Rect.fromLTWH(x + cellSize - borderWidth, y, borderWidth, cellSize),
        fillPaint,
      );
    }
  }

  @override
  bool shouldRepaint(PiecePainter oldDelegate) {
    return oldDelegate.shape != shape || oldDelegate.isDragging != isDragging;
  }
}

class PieceBorderPainter extends CustomPainter {
  final List<List<int>> shape;
  final double cellSize;
  final Color borderColor;

  PieceBorderPainter({
    required this.shape,
    required this.cellSize,
    required this.borderColor,
  });

  int get width => shape.isNotEmpty ? shape[0].length : 0;
  int get height => shape.length;

  @override
  void paint(Canvas canvas, Size size) {
    final draggingBorderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = borderColor
      ..strokeWidth = 2;

    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        if (shape[row][col] == 1) {
          final x = col * cellSize;
          final y = row * cellSize;
          _drawCellOutline(canvas, x, y, row, col, draggingBorderPaint);
        }
      }
    }
  }

  void _drawCellOutline(
    Canvas canvas,
    double x,
    double y,
    int row,
    int col,
    Paint paint,
  ) {
    final borderWidth = paint.strokeWidth;
    final fillPaint = Paint()
      ..color = paint.color
      ..style = PaintingStyle.fill;

    // Draw top edge if there's no cell above or if it's the top edge of the shape
    if (row == 0 || shape[row - 1][col] == 0) {
      canvas.drawRect(Rect.fromLTWH(x, y, cellSize, borderWidth), fillPaint);
    }

    // Draw bottom edge if there's no cell below or if it's the bottom edge of the shape
    if (row == height - 1 || shape[row + 1][col] == 0) {
      canvas.drawRect(
        Rect.fromLTWH(x, y + cellSize - borderWidth, cellSize, borderWidth),
        fillPaint,
      );
    }

    // Draw left edge if there's no cell to the left or if it's the left edge of the shape
    if (col == 0 || shape[row][col - 1] == 0) {
      canvas.drawRect(Rect.fromLTWH(x, y, borderWidth, cellSize), fillPaint);
    }

    // Draw right edge if there's no cell to the right or if it's the right edge of the shape
    if (col == width - 1 || shape[row][col + 1] == 0) {
      canvas.drawRect(
        Rect.fromLTWH(x + cellSize - borderWidth, y, borderWidth, cellSize),
        fillPaint,
      );
    }
  }

  @override
  bool shouldRepaint(PieceBorderPainter oldDelegate) {
    return oldDelegate.shape != shape;
  }
}

@Preview(name: "Piece Widget")
Widget pieceWidgetChristmasPreview() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 16,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      BoardPiece(
        shape: [
          [0, 1],
          [0, 1],
          [1, 1],
        ],
        svgAssetPath: 'assets/skins/l_christmas.svg',
      ),
      BoardPiece(
        shape: [
          [0, 1, 0],
          [1, 1, 1],
        ],
        svgAssetPath: 'assets/skins/t_christmas.svg',
      ),
      BoardPiece(
        shape: [
          [0, 1],
          [0, 1],
          [1, 1],
        ],
        color: Colors.greenAccent,
      ),
    ],
  );
}
