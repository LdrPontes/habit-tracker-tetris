import 'package:flutter/material.dart';
import 'package:blockin/app/board/domain/model/piece.dart';
import 'package:blockin/app/board/domain/model/piece_skin.dart';
import 'package:blockin/app/board/ui/components/atoms/board_piece.dart';
import 'package:flutter/widget_previews.dart';

class DraggableBoardPiece extends StatefulWidget {
  final Piece piece;
  final double cellSize;

  const DraggableBoardPiece({
    super.key,
    required this.piece,
    this.cellSize = 25.0,
  });

  @override
  State<DraggableBoardPiece> createState() => _DraggableBoardPieceState();
}

class _DraggableBoardPieceState extends State<DraggableBoardPiece> {
  late Piece _currentPiece;

  @override
  void initState() {
    super.initState();
    _currentPiece = widget.piece.copyWith();
  }

  void _handleTap() {
    setState(() {
      _currentPiece = _currentPiece.rotate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Draggable<Piece>(
        data: _currentPiece,
        feedback: BoardPiece(
          piece: _currentPiece,
          cellSize: widget.cellSize,
          isDragging: true,
        ),
        childWhenDragging: BoardPiece(
          piece: _currentPiece.copyWith(skin: PieceSkin.color(Colors.green)),
          cellSize: widget.cellSize,
        ),
        child: BoardPiece(
          piece: _currentPiece,
          cellSize: widget.cellSize,
          isDragging: false,
        ),
      ),
    );
  }
}

@Preview(name: "Draggable Board Piece")
Widget draggableBoardPiecePreview() {
  return DraggableBoardPiece(
    piece: Piece(
      shape: [
        [0, 1],
        [1, 1],
      ],
      skin: PieceSkin.color(Colors.greenAccent),
    ),
  );
}
