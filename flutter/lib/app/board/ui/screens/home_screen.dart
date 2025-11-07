import 'package:flutter/material.dart';
import 'package:blockin/app/board/domain/model/board.dart';
import 'package:blockin/app/board/domain/model/piece.dart';
import 'package:blockin/app/board/domain/model/piece_skin.dart';
import 'package:blockin/app/board/ui/components/molecules/draggable_board_piece.dart';
import 'package:blockin/app/board/ui/components/molecules/droppable_board.dart';
import 'package:blockin/constants/skins.dart';

class TetrisDemoScreen extends StatefulWidget {
  static const String routeName = '/tetris-demo';
  const TetrisDemoScreen({super.key});

  @override
  State<TetrisDemoScreen> createState() => _TetrisDemoScreenState();
}

class _TetrisDemoScreenState extends State<TetrisDemoScreen> {
  late Board _board;

  @override
  void initState() {
    super.initState();
    _board = Board();
  }

  bool _canPlacePiece(List<List<int>> shape, int row, int col, int totalRows) {
    // Create a temporary Piece to use the board's canPlacePiece method
    final tempPiece = Piece(shape: shape, skin: PieceSkin.color(Colors.grey));
    return _board.canPlacePiece(tempPiece, row, col, totalRows);
  }

  PlacedPieceData? _onPiecePlaced(
    List<List<int>> shape,
    Color? color,
    String? svgAssetPath,
    int rotationDegrees,
    int row,
    int col,
    int totalRows,
  ) {
    // Create a Piece with the provided data
    final piece = Piece(
      shape: shape,
      skin: svgAssetPath != null
          ? PieceSkin.svg(svgAssetPath, rotationDegrees)
          : PieceSkin.color(color ?? Colors.grey, rotationDegrees),
    );

    // Try to place the piece on the board
    final newBoard = _board.placePiece(piece, row, col, totalRows);

    if (newBoard != null) {
      setState(() {
        _board = newBoard;
      });

      // Return the placed piece data
      final placedPiece = newBoard.placedPieces.last;
      return PlacedPieceData(
        shape: placedPiece.shape,
        color: placedPiece.skin.color,
        svgAssetPath: placedPiece.skin.svgAssetPath,
        rotationDegrees: placedPiece.skin.rotationDegrees,
        x: placedPiece.x,
        y: placedPiece.y,
      );
    }

    return null;
  }

  List<PlacedPieceData> _getPlacedPieces() {
    return _board.placedPieces.map((piece) {
      return PlacedPieceData(
        shape: piece.shape,
        color: piece.skin.color,
        svgAssetPath: piece.skin.svgAssetPath,
        rotationDegrees: piece.skin.rotationDegrees,
        x: piece.x,
        y: piece.y,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DroppableBoard(
                cols: _board.cols,
                rows: _board.rows,
                placedPieces: _getPlacedPieces(),
                canPlacePiece: _canPlacePiece,
                onPiecePlaced: _onPiecePlaced,
              ),
              const SizedBox(height: 48),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 16,
                  children: [
                    DraggableBoardPiece(
                      cellSize: MediaQuery.of(context).size.width / 12,
                      initialShape: [
                        [0, 1],
                        [1, 1],
                      ],
                      color: Colors.greenAccent,
                    ),
                    DraggableBoardPiece(
                      cellSize: MediaQuery.of(context).size.width / 12,
                      initialShape: [
                        [1, 1],
                      ],
                      color: Colors.blueAccent,
                    ),
                    DraggableBoardPiece(
                      cellSize: MediaQuery.of(context).size.width / 12,
                      initialShape: [
                        [0, 1, 0],
                        [1, 1, 1],
                      ],
                      svgAssetPath: SkinsAssets.tChristmas,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
