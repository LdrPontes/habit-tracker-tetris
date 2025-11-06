import 'dart:math';

import 'package:flutter/material.dart';
import 'package:starter/app/board/domain/model/board.dart';
import 'package:starter/app/board/domain/model/piece.dart';
import 'package:starter/app/board/ui/components/atoms/board_piece.dart';
import 'package:flutter/widget_previews.dart';

class DroppableBoard extends StatefulWidget {
  final Board board;
  const DroppableBoard({super.key, required this.board});

  @override
  State<DroppableBoard> createState() => _DroppableBoardState();
}

class _DroppableBoardState extends State<DroppableBoard> {
  late Board _board;
  Piece? _hoveringPiece;
  int? _hoverRow;
  int? _hoverCol;

  @override
  void initState() {
    super.initState();
    _board = widget.board.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Piece>(
      onAcceptWithDetails: (details) => _onAcceptWithDetails(context, details),
      onLeave: _onLeave,
      onWillAcceptWithDetails: (_) => true,
      onMove: (details) => _onMove(context, details),
      builder: (context, candidateData, rejectedData) => LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = MediaQuery.of(context).size.height * 0.8;
          // Fixed 12 columns, cell size based on width
          final cellSize = constraints.maxWidth / 12;
          final boardHeight = _board.rows * cellSize;
          // Height starts at 0, but minimum is screen height
          final finalHeight = max(boardHeight, screenHeight);

          // Calculate total rows for validation
          final totalRows = (finalHeight / cellSize).ceil();

          // Check if piece can be placed
          bool canPlace = true;
          if (_hoveringPiece != null &&
              _hoverRow != null &&
              _hoverCol != null) {
            canPlace = _board.canPlacePiece(
              _hoveringPiece!,
              _hoverRow!,
              _hoverCol!,
              totalRows,
            );
          }

          return Stack(
            children: [
              // Draw grid only
              CustomPaint(
                size: Size(constraints.maxWidth, finalHeight),
                painter: DroppableBoardPainter(
                  board: _board,
                  cellSize: cellSize,
                  hoveringPiece: _hoveringPiece,
                  hoverRow: _hoverRow,
                  hoverCol: _hoverCol,
                  canPlacePiece: canPlace,
                ),
              ),
              // Draw all placed pieces using BoardPiece component
              ..._buildPlacedPieces(cellSize, totalRows),
            ],
          );
        },
      ),
    );
  }

  void _onAcceptWithDetails(BuildContext context, details) {
    // Calculate cell size from screen width (12 columns)
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height * 0.8;
    final cellSize = screenWidth / 12;

    // Calculate total rows (same logic as in builder)
    final boardHeight = _board.rows * cellSize;
    final finalHeight = max(boardHeight, screenHeight);
    final totalRows = (finalHeight / cellSize).ceil().toInt();

    // Get the drop position
    final dropOffset = details.offset;

    // Calculate which cell (row, col) the piece was dropped on
    final col = (dropOffset.dx / cellSize).floor().toInt();
    final rowFromTop = (dropOffset.dy / cellSize).floor().toInt();
    // Invert row: row 0 is at the bottom, increasing upward
    final row = (totalRows - 1 - rowFromTop).toInt();

    print('[DroppableBoard] Piece placed at position:');
    print(
      '  - Drop offset: (${dropOffset.dx.toStringAsFixed(2)}, ${dropOffset.dy.toStringAsFixed(2)})',
    );
    print('  - Cell position: Row=$row (from bottom), Col=$col');
    print('  - Piece: ${details.data}');

    // Try to place the piece on the board
    final newBoard = _board.placePiece(details.data, row, col, totalRows);

    if (newBoard != null) {
      // Piece was successfully placed
      setState(() {
        _board = newBoard;
        _hoveringPiece = null;
        _hoverRow = null;
        _hoverCol = null;
      });
      print('[DroppableBoard] Piece successfully placed on board');
    } else {
      // Piece could not be placed - clear hover state
      setState(() {
        _hoveringPiece = null;
        _hoverRow = null;
        _hoverCol = null;
      });
      print('[DroppableBoard] Failed to place piece - invalid position');
    }
  }

  void _onLeave(data) {
    print('[DroppableBoard] onLeave: $data');
    setState(() {
      _hoveringPiece = null;
      _hoverRow = null;
      _hoverCol = null;
    });
  }

  void _onMove(BuildContext context, details) {
    // Calculate cell size from screen width (12 columns)
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height * 0.8;
    final cellSize = screenWidth / 12;

    // Calculate total rows (same logic as in builder)
    final boardHeight = _board.rows * cellSize;
    final finalHeight = max(boardHeight, screenHeight);
    final totalRows = (finalHeight / cellSize).ceil().toInt();

    // Get the current position while moving
    final currentOffset = details.offset;
    final col = (currentOffset.dx / cellSize).floor().toInt();
    final rowFromTop = (currentOffset.dy / cellSize).floor().toInt();
    // Invert row: row 0 is at the bottom, increasing upward
    final row = (totalRows - 1 - rowFromTop).toInt();

    print(
      '[DroppableBoard] onMove: Row=$row (from bottom), Col=$col, Piece=${details.data}',
    );

    setState(() {
      _hoveringPiece = details.data;
      _hoverRow = row;
      _hoverCol = col;
    });
  }

  List<Widget> _buildPlacedPieces(double cellSize, int totalRows) {
    final pieces = <Widget>[];

    for (final piece in _board.placedPieces) {
      final pieceWidth = piece.width * cellSize;
      final pieceHeight = piece.height * cellSize;

      // Calculate position on screen
      // Convert from board coordinates (bottom-up) to screen coordinates (top-down)
      // y is the base of the piece (row), so the top is at y + (height - 1)
      final boardRowTop = piece.y + (piece.height - 1);
      final rowFromTop = totalRows - 1 - boardRowTop;
      final x = piece.x * cellSize;
      final y = rowFromTop * cellSize;

      pieces.add(
        Positioned(
          left: x,
          top: y,
          width: pieceWidth,
          height: pieceHeight,
          child: BoardPiece(
            piece: piece,
            cellSize: cellSize,
            isDragging: false,
          ),
        ),
      );
    }

    return pieces;
  }
}

class DroppableBoardPainter extends CustomPainter {
  final Board board;
  final double cellSize;
  final Piece? hoveringPiece;
  final int? hoverRow;
  final int? hoverCol;
  final bool canPlacePiece;

  DroppableBoardPainter({
    required this.board,
    required this.cellSize,
    this.hoveringPiece,
    this.hoverRow,
    this.hoverCol,
    this.canPlacePiece = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.grey.shade300;

    final rows = (size.height / cellSize).ceil();

    // Draw grid cells - always 12 columns
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < board.cols; col++) {
        final x = col * cellSize;
        final y = row * cellSize;

        final rect = Rect.fromLTWH(x, y, cellSize, cellSize);

        // Draw cell border
        canvas.drawRect(rect, borderPaint);
      }
    }

    // Placed pieces are now drawn using BoardPiece widgets in the Stack
    // Only draw hovering piece preview here
    if (hoveringPiece != null && hoverRow != null && hoverCol != null) {
      _drawHoveringPiece(canvas, size, hoveringPiece!, hoverRow!, hoverCol!);
    }
  }

  void _drawHoveringPiece(
    Canvas canvas,
    Size size,
    Piece piece,
    int row,
    int col,
  ) {
    final rows = (size.height / cellSize).ceil();

    // Get piece color with transparency for preview
    // Use red if cannot place, otherwise use piece color
    // For SVG pieces, use a default color for preview
    Color pieceColor;
    if (piece.skin.isSvg) {
      pieceColor = canPlacePiece ? Colors.purple.shade400 : Colors.red;
    } else {
      pieceColor = canPlacePiece
          ? (piece.skin.color ?? Colors.grey)
          : Colors.red;
    }
    final previewColor = pieceColor.withAlpha((255 * 0.5).toInt());

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = previewColor;

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = pieceColor;

    // Draw each cell of the piece shape
    // Note: shape[0] is top (in PiecePainter), but board row 0 is bottom
    // So we need to invert: shape[height-1] goes to row, shape[0] goes to row + (height-1)
    for (int py = 0; py < piece.height; py++) {
      for (int px = 0; px < piece.width; px++) {
        // Only draw if this cell is part of the piece (shape[py][px] == 1)
        if (piece.shape[py][px] == 1) {
          // Calculate board position
          // Invert py: shape[0] (top) should be at row + (height-1), shape[height-1] (bottom) should be at row
          final boardCol = col + px;
          final boardRow = row + (piece.height - 1 - py);

          // Check if position is within board bounds
          if (boardCol >= 0 &&
              boardCol < board.cols &&
              boardRow >= 0 &&
              boardRow < rows) {
            // Convert row from bottom-up to top-down for drawing
            final rowFromTop = rows - 1 - boardRow;
            final x = boardCol * cellSize;
            final y = rowFromTop * cellSize;

            final rect = Rect.fromLTWH(x, y, cellSize, cellSize);

            // Draw filled cell
            canvas.drawRect(rect, fillPaint);
            // Draw border
            canvas.drawRect(rect, borderPaint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(DroppableBoardPainter oldDelegate) {
    return oldDelegate.cellSize != cellSize ||
        oldDelegate.board != board ||
        oldDelegate.hoveringPiece != hoveringPiece ||
        oldDelegate.hoverRow != hoverRow ||
        oldDelegate.hoverCol != hoverCol ||
        oldDelegate.canPlacePiece != canPlacePiece;
  }
}

@Preview(name: "Board")
Widget boardPreview() {
  return DroppableBoard(board: Board());
}
