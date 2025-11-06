import 'package:flutter/material.dart';
import 'package:starter/app/board/domain/model/board.dart' as board_model;
import 'package:starter/app/board/domain/model/piece.dart';
import 'package:starter/app/board/domain/model/piece_skin.dart';
import 'package:starter/app/board/ui/components/molecules/draggable_board_piece.dart';
import 'package:starter/app/board/ui/components/molecules/droppable_board.dart';
import 'package:starter/constants/skins.dart';

class TetrisDemoScreen extends StatefulWidget {
  static const String routeName = '/tetris-demo';
  const TetrisDemoScreen({super.key});

  @override
  State<TetrisDemoScreen> createState() => _TetrisDemoScreenState();
}

class _TetrisDemoScreenState extends State<TetrisDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DroppableBoard(board: board_model.Board()),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 16,
                  children: [
                    DraggableBoardPiece(
                      cellSize: MediaQuery.of(context).size.width / 12,
                      piece: Piece(
                        shape: [
                          [0, 1],
                          [1, 1],
                        ],
                        skin: PieceSkin.color(Colors.greenAccent),
                      ),
                    ),
                    DraggableBoardPiece(
                      cellSize: MediaQuery.of(context).size.width / 12,
                      piece: Piece(
                        shape: [
                          [1, 1],
                        ],
                        skin: PieceSkin.color(Colors.blueAccent),
                      ),
                    ),
                    DraggableBoardPiece(
                      cellSize: MediaQuery.of(context).size.width / 12,
                      piece: Piece(
                        shape: [
                          [0, 1, 0],
                          [1, 1, 1],
                        ],
                        skin: PieceSkin.svg(SkinsAssets.tChristmas),
                      ),
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
