import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:blockin/app/board/domain/model/piece.dart';
import 'package:flutter/widget_previews.dart';
import 'package:blockin/app/board/domain/model/piece_skin.dart';
import 'package:blockin/constants/skins.dart';

class BoardPiece extends StatelessWidget {
  final Piece piece;
  final double cellSize;
  final bool isDragging;

  const BoardPiece({
    super.key,
    required this.piece,
    this.cellSize = 25.0,
    this.isDragging = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color draggingBorderColor = Colors.black.withAlpha(
      (255 * 0.3).toInt(),
    );
    return piece.skin.isSvg
        ? _buildSvg(piece.skin.svgAssetPath!, draggingBorderColor)
        : _buildColor(piece.skin.color!, draggingBorderColor);
  }

  Widget _buildSvg(String svgAssetPath, Color draggingBorderColor) {
    return Stack(
      children: [
        SvgPicture.asset(
          svgAssetPath,
          width: cellSize * piece.width,
          height: cellSize * piece.height,
        ),
        if (isDragging)
          CustomPaint(
            size: Size(piece.width * cellSize, piece.height * cellSize),
            painter: PieceBorderPainter(
              piece: piece,
              cellSize: cellSize,
              borderColor: draggingBorderColor,
            ),
          ),
      ],
    );
  }

  Widget _buildColor(Color color, Color draggingBorderColor) {
    return CustomPaint(
      size: Size(piece.width * cellSize, piece.height * cellSize),
      painter: PiecePainter(
        piece: piece,
        cellSize: cellSize,
        isDragging: isDragging,
        borderColor: draggingBorderColor,
      ),
    );
  }
}

class PiecePainter extends CustomPainter {
  final Piece piece;
  final double cellSize;
  final bool isDragging;
  final Color borderColor;
  PiecePainter({
    required this.piece,
    required this.cellSize,
    required this.borderColor,
    this.isDragging = false,
  });

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

    for (int row = 0; row < piece.height; row++) {
      for (int col = 0; col < piece.width; col++) {
        if (piece.shape[row][col] == 1) {
          final x = col * cellSize;
          final y = row * cellSize;

          // Set color based on skin
          if (piece.skin.isSvg) {
            // For SVG, use a default color (could be improved to render SVG)
            cellPaint.color = Colors.purple.shade400;
          } else {
            cellPaint.color = piece.skin.color ?? Colors.blue.shade400;
          }

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
    if (row == 0 || piece.shape[row - 1][col] == 0) {
      canvas.drawRect(Rect.fromLTWH(x, y, cellSize, borderWidth), fillPaint);
    }

    // Draw bottom edge if there's no cell below or if it's the bottom edge of the shape
    if (row == piece.height - 1 || piece.shape[row + 1][col] == 0) {
      canvas.drawRect(
        Rect.fromLTWH(x, y + cellSize - borderWidth, cellSize, borderWidth),
        fillPaint,
      );
    }

    // Draw left edge if there's no cell to the left or if it's the left edge of the shape
    if (col == 0 || piece.shape[row][col - 1] == 0) {
      canvas.drawRect(Rect.fromLTWH(x, y, borderWidth, cellSize), fillPaint);
    }

    // Draw right edge if there's no cell to the right or if it's the right edge of the shape
    if (col == piece.width - 1 || piece.shape[row][col + 1] == 0) {
      canvas.drawRect(
        Rect.fromLTWH(x + cellSize - borderWidth, y, borderWidth, cellSize),
        fillPaint,
      );
    }
  }

  @override
  bool shouldRepaint(PiecePainter oldDelegate) {
    return oldDelegate.piece != piece || oldDelegate.isDragging != isDragging;
  }
}

class PieceBorderPainter extends CustomPainter {
  final Piece piece;
  final double cellSize;
  final Color borderColor;

  PieceBorderPainter({
    required this.piece,
    required this.cellSize,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final draggingBorderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = borderColor
      ..strokeWidth = 2;

    for (int row = 0; row < piece.height; row++) {
      for (int col = 0; col < piece.width; col++) {
        if (piece.shape[row][col] == 1) {
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
    if (row == 0 || piece.shape[row - 1][col] == 0) {
      canvas.drawRect(Rect.fromLTWH(x, y, cellSize, borderWidth), fillPaint);
    }

    // Draw bottom edge if there's no cell below or if it's the bottom edge of the shape
    if (row == piece.height - 1 || piece.shape[row + 1][col] == 0) {
      canvas.drawRect(
        Rect.fromLTWH(x, y + cellSize - borderWidth, cellSize, borderWidth),
        fillPaint,
      );
    }

    // Draw left edge if there's no cell to the left or if it's the left edge of the shape
    if (col == 0 || piece.shape[row][col - 1] == 0) {
      canvas.drawRect(Rect.fromLTWH(x, y, borderWidth, cellSize), fillPaint);
    }

    // Draw right edge if there's no cell to the right or if it's the right edge of the shape
    if (col == piece.width - 1 || piece.shape[row][col + 1] == 0) {
      canvas.drawRect(
        Rect.fromLTWH(x + cellSize - borderWidth, y, borderWidth, cellSize),
        fillPaint,
      );
    }
  }

  @override
  bool shouldRepaint(PieceBorderPainter oldDelegate) {
    return oldDelegate.piece != piece;
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
        piece: Piece(
          shape: [
            [0, 1],
            [0, 1],
            [1, 1],
          ],
          skin: PieceSkin.svg(SkinsAssets.lChristmas),
        ),
      ),
      BoardPiece(
        piece: Piece(
          shape: [
            [0, 1, 0],
            [1, 1, 1],
          ],
          skin: PieceSkin.svg(SkinsAssets.tChristmas),
        ),
      ),
      BoardPiece(
        piece: Piece(
          shape: [
            [0, 1],
            [0, 1],
            [1, 1],
          ],
          skin: PieceSkin.color(Colors.greenAccent),
        ),
      ),
    ],
  );
}
