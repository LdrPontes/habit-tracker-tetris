import 'package:flutter/material.dart';
import 'package:starter/app/board/domain/model/piece.dart';
import 'package:starter/app/board/domain/model/piece_skin.dart';
import 'package:starter/app/board/ui/components/atoms/board_piece.dart';
import 'package:flutter/widget_previews.dart';

class DraggableBoardPiece extends StatelessWidget {
  final Piece piece;
  final double cellSize;

  const DraggableBoardPiece({
    super.key,
    required this.piece,
    this.cellSize = 25.0,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<Piece>(
      data: piece,
      feedback: BoardPiece(piece: piece, cellSize: cellSize, isDragging: true),
      childWhenDragging: BoardPiece(
        piece: piece.copyWith(skin: PieceSkin.color(Colors.green)),
        cellSize: cellSize,
      ),
      child: BoardPiece(piece: piece, cellSize: cellSize, isDragging: false),
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
