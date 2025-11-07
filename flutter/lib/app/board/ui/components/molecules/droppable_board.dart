import 'dart:math';

import 'package:flutter/material.dart';
import 'package:blockin/app/board/domain/model/board.dart';
import 'package:blockin/app/board/domain/model/piece.dart';
import 'package:blockin/app/board/ui/components/atoms/board_piece.dart';
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
          final (cellSize, totalRows, finalHeight) = _calculateBoardDimensions(
            constraints.maxWidth,
            context,
          );
          final canPlace = _canPlaceHoveringPiece(totalRows);

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

  // Calculate board dimensions (cellSize, totalRows, finalHeight)
  (double, int, double) _calculateBoardDimensions(
    double width,
    BuildContext context,
  ) {
    final screenHeight = MediaQuery.of(context).size.height * 0.8;
    // Fixed 12 columns, cell size based on width
    final cellSize = width / 12;
    final boardHeight = _board.rows * cellSize;
    // Height starts at 0, but minimum is screen height
    final finalHeight = max(boardHeight, screenHeight);
    // Calculate total rows for validation
    final totalRows = (finalHeight / cellSize).ceil().toInt();
    return (cellSize, totalRows, finalHeight);
  }

  // Check if hovering piece can be placed
  bool _canPlaceHoveringPiece(int totalRows) {
    if (_hoveringPiece == null || _hoverRow == null || _hoverCol == null) {
      return true;
    }
    return _board.canPlacePiece(
      _hoveringPiece!,
      _hoverRow!,
      _hoverCol!,
      totalRows,
    );
  }

  // Calculate feedback offset for drag preview
  Offset _calculateFeedbackOffset(Piece piece, double cellSize) {
    return Offset(0, -(piece.height * cellSize * 1.5));
  }

  // Calculate cell position (row, col) from offset
  (int, int) _calculateCellPosition(
    Offset offset,
    double cellSize,
    int totalRows,
  ) {
    final col = (offset.dx / cellSize).floor().toInt();
    final rowFromTop = (offset.dy / cellSize).floor().toInt();
    // Invert row: row 0 is at the bottom, increasing upward
    final row = (totalRows - 1 - rowFromTop).toInt();
    return (row, col);
  }

  // Clear hover state
  void _clearHoverState() {
    setState(() {
      _hoveringPiece = null;
      _hoverRow = null;
      _hoverCol = null;
    });
  }

  void _onAcceptWithDetails(
    BuildContext context,
    DragTargetDetails<Piece> details,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final (cellSize, totalRows, _) = _calculateBoardDimensions(
      screenWidth,
      context,
    );

    // Get the drop position
    // Adjust for feedbackOffset so drop position matches where the visual piece is
    final feedbackOffset = _calculateFeedbackOffset(details.data, cellSize);
    final dropOffset = details.offset - feedbackOffset;
    final (row, col) = _calculateCellPosition(dropOffset, cellSize, totalRows);

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
      });
      _clearHoverState();
      print('[DroppableBoard] Piece successfully placed on board');
    } else {
      // Piece could not be placed - clear hover state
      _clearHoverState();
      print('[DroppableBoard] Failed to place piece - invalid position');
    }
  }

  void _onLeave(data) {
    print('[DroppableBoard] onLeave: $data');
    _clearHoverState();
  }

  void _onMove(BuildContext context, DragTargetDetails<Piece> details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final (cellSize, totalRows, _) = _calculateBoardDimensions(
      screenWidth,
      context,
    );

    // Get the current position while moving
    // Adjust for feedbackOffset so hover appears where the visual piece is
    final feedbackOffset = _calculateFeedbackOffset(details.data, cellSize);
    final currentOffset = details.offset - feedbackOffset;
    final (row, col) = _calculateCellPosition(
      currentOffset,
      cellSize,
      totalRows,
    );

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
    return _board.placedPieces.map((piece) {
      // Calculate position on screen
      // Convert from board coordinates (bottom-up) to screen coordinates (top-down)
      // y is the base of the piece (row), so the top is at y + (height - 1)
      final boardRowTop = piece.y + (piece.height - 1);
      final rowFromTop = totalRows - 1 - boardRowTop;

      return Positioned(
        left: piece.x * cellSize,
        top: rowFromTop * cellSize,
        width: piece.width * cellSize,
        height: piece.height * cellSize,
        child: BoardPiece(piece: piece, cellSize: cellSize, isDragging: false),
      );
    }).toList();
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
    _drawGrid(canvas, size);
    // Placed pieces are now drawn using BoardPiece widgets in the Stack
    // Only draw hovering piece preview here
    if (hoveringPiece != null && hoverRow != null && hoverCol != null) {
      _drawHoveringPiece(canvas, size, hoveringPiece!, hoverRow!, hoverCol!);
    }
  }

  // Draw grid cells - always 12 columns
  void _drawGrid(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.grey.shade300;

    final rows = (size.height / cellSize).ceil();
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < board.cols; col++) {
        canvas.drawRect(
          Rect.fromLTWH(col * cellSize, row * cellSize, cellSize, cellSize),
          borderPaint,
        );
      }
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
    final pieceColor = _getPieceColor(piece);
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
            final rect = Rect.fromLTWH(
              boardCol * cellSize,
              rowFromTop * cellSize,
              cellSize,
              cellSize,
            );

            // Draw filled cell
            canvas.drawRect(rect, fillPaint);
            // Draw border
            canvas.drawRect(rect, borderPaint);
          }
        }
      }
    }
  }

  // Get piece color with transparency for preview
  // Use red if cannot place, otherwise use piece color
  // For SVG pieces, use a default color for preview
  Color _getPieceColor(Piece piece) {
    if (piece.skin.isSvg) {
      return canPlacePiece ? Colors.purple.shade400 : Colors.red;
    }
    return canPlacePiece ? (piece.skin.color ?? Colors.grey) : Colors.red;
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
