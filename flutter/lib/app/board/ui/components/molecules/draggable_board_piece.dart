import 'package:flutter/material.dart';
import 'package:blockin/app/board/ui/components/atoms/board_piece.dart';
import 'package:flutter/widget_previews.dart';

class DraggablePieceData {
  final List<List<int>> shape;
  final Color? color;
  final String? svgAssetPath;
  final int rotationDegrees;

  const DraggablePieceData({
    required this.shape,
    this.color,
    this.svgAssetPath,
    this.rotationDegrees = 0,
  }) : assert(
         (color != null && svgAssetPath == null) ||
             (color == null && svgAssetPath != null),
         'Either color or svgAssetPath must be provided, but not both',
       );
}

class DraggableBoardPiece extends StatefulWidget {
  final List<List<int>> initialShape;
  final Color? color;
  final String? svgAssetPath;
  final int initialRotationDegrees;
  final double cellSize;
  final DraggablePieceData Function(DraggablePieceData)? onRotate;

  const DraggableBoardPiece({
    super.key,
    required this.initialShape,
    this.color,
    this.svgAssetPath,
    this.initialRotationDegrees = 0,
    this.cellSize = 25.0,
    this.onRotate,
  }) : assert(
         (color != null && svgAssetPath == null) ||
             (color == null && svgAssetPath != null),
         'Either color or svgAssetPath must be provided, but not both',
       );

  @override
  State<DraggableBoardPiece> createState() => _DraggableBoardPieceState();
}

class _DraggableBoardPieceState extends State<DraggableBoardPiece> {
  late DraggablePieceData _currentPiece;

  @override
  void initState() {
    super.initState();
    _currentPiece = DraggablePieceData(
      shape: widget.initialShape,
      color: widget.color,
      svgAssetPath: widget.svgAssetPath,
      rotationDegrees: widget.initialRotationDegrees,
    );
  }

  void _handleTap() {
    setState(() {
      if (widget.onRotate != null) {
        _currentPiece = widget.onRotate!(_currentPiece);
      } else {
        // Default rotation: 90° clockwise
        final rotated = List.generate(
          _currentPiece.shape.isNotEmpty ? _currentPiece.shape[0].length : 0,
          (x) => List<int>.filled(_currentPiece.shape.length, 0),
        );
        for (int y = 0; y < _currentPiece.shape.length; y++) {
          for (
            int x = 0;
            x <
                (_currentPiece.shape.isNotEmpty
                    ? _currentPiece.shape[0].length
                    : 0);
            x++
          ) {
            rotated[x][_currentPiece.shape.length - 1 - y] =
                _currentPiece.shape[y][x];
          }
        }
        final newRotation = (_currentPiece.rotationDegrees + 90) % 360;
        _currentPiece = DraggablePieceData(
          shape: rotated,
          color: _currentPiece.color,
          svgAssetPath: _currentPiece.svgAssetPath,
          rotationDegrees: newRotation,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Draggable<DraggablePieceData>(
        data: _currentPiece,
        feedback: BoardPiece(
          shape: _currentPiece.shape,
          color: _currentPiece.color,
          svgAssetPath: _currentPiece.svgAssetPath,
          rotationDegrees: _currentPiece.rotationDegrees,
          cellSize: widget.cellSize,
          isDragging: true,
        ),
        childWhenDragging: BoardPiece(
          shape: _currentPiece.shape,
          color: Colors.green,
          cellSize: widget.cellSize,
        ),
        child: BoardPiece(
          shape: _currentPiece.shape,
          color: _currentPiece.color,
          svgAssetPath: _currentPiece.svgAssetPath,
          rotationDegrees: _currentPiece.rotationDegrees,
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
    initialShape: [
      [0, 1],
      [1, 1],
    ],
    color: Colors.greenAccent,
  );
}
