import 'package:blockin/app/board/domain/model/piece_skin.dart';

class Piece {
  final List<List<int>> shape; // Matrix 2D representing the piece shape
  final PieceSkin skin; // Piece skin
  int x; // X position on the board (column)
  int y; // Y position on the board (row)

  Piece({required this.shape, required this.skin, this.x = 0, this.y = 0});

  int get height => shape.length;
  int get width => shape[0].length;

  /// Rotates the piece (90° clockwise)
  /// Also rotates the skin if it's an SVG
  Piece rotate() {
    final rotated = List.generate(width, (x) => List<int>.filled(height, 0));
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        rotated[x][height - 1 - y] = shape[y][x];
      }
    }
    final rotatedSkin = skin.rotate();
    return Piece(shape: rotated, skin: rotatedSkin, x: x, y: y);
  }

  Piece copyWith({List<List<int>>? shape, PieceSkin? skin, int? x, int? y}) {
    return Piece(
      shape: shape ?? this.shape,
      skin: skin ?? this.skin,
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  /// Returns a visual representation of the shape with rows inverted.
  /// shape[height-1] (base) appears at the bottom, matching the board's coordinate system.
  String toStringShape() {
    if (shape.isEmpty) return 'Empty shape';

    // Invert rows: shape[0] is top in internal representation, but base is at shape[height-1] (bottom)
    final invertedShape = shape.toList();
    return invertedShape.map((row) => row.toString()).join('\n');
  }

  @override
  String toString() {
    return 'Piece(shape: $shape, skin: $skin, x: $x, y: $y)';
  }
}
