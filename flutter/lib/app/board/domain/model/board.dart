import 'package:blockin/app/board/domain/model/piece.dart';

class Board {
  final int cols;
  final List<Piece> placedPieces;
  // Keep grid for backward compatibility and support checking
  List<List<int>> grid = List.empty(growable: true); // 0 = empty, 1 = occupied

  Board({this.cols = 12, List<Piece>? placedPieces, List<List<int>>? grid})
    : placedPieces = placedPieces ?? [],
      grid =
          grid ??
          (placedPieces == null
              ? List.generate(4, (index) => List.generate(cols, (index) => 0))
              : _buildGridFromPieces(placedPieces, cols));

  static List<List<int>> _buildGridFromPieces(List<Piece> pieces, int cols) {
    if (pieces.isEmpty) {
      return List.generate(4, (index) => List.generate(cols, (index) => 0));
    }

    // Find the maximum row needed
    int maxRow = 0;
    for (final piece in pieces) {
      final maxPieceRow = piece.y + piece.height - 1;
      if (maxPieceRow > maxRow) {
        maxRow = maxPieceRow;
      }
    }

    // Build grid from pieces
    final newGrid = List.generate(
      maxRow + 1,
      (index) => List.generate(cols, (index) => 0),
    );

    for (final piece in pieces) {
      for (int py = 0; py < piece.height; py++) {
        for (int px = 0; px < piece.width; px++) {
          if (piece.shape[py][px] == 1) {
            final boardCol = piece.x + px;
            final boardRow = piece.y + (piece.height - 1 - py);
            if (boardRow >= 0 &&
                boardRow < newGrid.length &&
                boardCol >= 0 &&
                boardCol < cols) {
              newGrid[boardRow][boardCol] = 1;
            }
          }
        }
      }
    }

    return newGrid;
  }

  int get rows => grid.length;

  /// Checks if a piece can be placed at a specific position on the board.
  ///
  /// Rules:
  /// 1. The piece cannot be outside the board boundaries
  /// 2. The piece cannot overlap already occupied cells
  /// 3. The piece must be on the ground or have support below (each base cell needs to be on the ground or have an occupied cell directly below)
  ///
  /// [piece]: The piece to be checked
  /// [row]: The row where the piece will be placed (0 = ground, increases upward)
  /// [col]: The column where the piece will be placed
  /// [totalRows]: The total number of rows available on the board (including virtual rows above the current grid)
  ///
  /// Returns `true` if the piece can be placed, `false` otherwise.
  bool canPlacePiece(Piece piece, int row, int col, int totalRows) {
    // First, check boundaries and overlap for all cells
    for (int py = 0; py < piece.height; py++) {
      for (int px = 0; px < piece.width; px++) {
        // Only check cells that are part of the piece
        if (piece.shape[py][px] == 1) {
          // Calculate position on the board
          // shape[0] is the top of the piece, shape[height-1] is the base
          // row is the row of the piece base (on ground = 0)
          final boardCol = col + px;
          final boardRow = row + (piece.height - 1 - py);

          // 1. Check if within horizontal boundaries
          if (boardCol < 0 || boardCol >= cols) {
            return false;
          }

          // 2. Check if within vertical boundaries
          if (boardRow < 0 || boardRow >= totalRows) {
            return false;
          }

          // 3. Check if there's no overlap with occupied cells
          // If the row exists in the current grid and is occupied
          if (boardRow < grid.length && grid[boardRow][boardCol] == 1) {
            return false;
          }
        }
      }
    }

    // Now check support: at least one base cell must be on the ground OR have support below
    // The base of the piece are the lowest cells in each column
    // In Tetris, a piece can be placed if AT LEAST ONE base cell is either on the ground or has support
    bool hasAnySupport = false;

    for (int px = 0; px < piece.width; px++) {
      // Find the lowest cell in this column of the piece
      int? lowestPy;
      for (int py = piece.height - 1; py >= 0; py--) {
        if (piece.shape[py][px] == 1) {
          lowestPy = py;
          break; // Found the lowest cell in this column
        }
      }

      // If there's a cell in this column
      if (lowestPy != null) {
        final boardCol = col + px;
        // Calculate the actual board row for this lowest cell
        // Using the same formula as in placePiece: row + (piece.height - 1 - py)
        final boardRow = row + (piece.height - 1 - lowestPy);

        // Check if this cell has support
        if (boardRow == 0) {
          // On the ground - has support
          hasAnySupport = true;
          break; // Found support, no need to check further
        }

        // Not on the ground - check if there's support below
        final rowBelow = boardRow - 1;
        if (rowBelow >= 0 && rowBelow < grid.length) {
          if (grid[rowBelow][boardCol] == 1) {
            hasAnySupport = true;
            break; // Found support, no need to check further
          }
        }
      }
    }

    // If no base cell has support, the piece cannot be placed
    return hasAnySupport;
  }

  /// Places a piece on the board at the specified position.
  ///
  /// This method will:
  /// 1. Validate that the piece can be placed (using canPlacePiece)
  /// 2. Expand the grid if necessary to accommodate the piece
  /// 3. Mark all cells occupied by the piece as occupied (1)
  ///
  /// [piece]: The piece to be placed
  /// [row]: The row where the piece will be placed (0 = ground, increases upward)
  /// [col]: The column where the piece will be placed
  /// [totalRows]: The total number of rows available on the board (including virtual rows above the current grid)
  ///
  /// Returns a new Board with the piece placed, or null if the piece cannot be placed.
  Board? placePiece(Piece piece, int row, int col, int totalRows) {
    // First, validate that the piece can be placed
    if (!canPlacePiece(piece, row, col, totalRows)) {
      return null;
    }

    // Create a deep copy of the grid
    final newGrid = grid.map((row) => List<int>.from(row)).toList();

    // Expand grid if necessary to accommodate the piece
    final maxRow = row + piece.height - 1;
    while (newGrid.length <= maxRow) {
      newGrid.add(List.generate(cols, (index) => 0));
    }

    // Place the piece on the board
    for (int py = 0; py < piece.height; py++) {
      for (int px = 0; px < piece.width; px++) {
        // Only place cells that are part of the piece
        if (piece.shape[py][px] == 1) {
          // Calculate position on the board
          // shape[0] is the top of the piece, shape[height-1] is the base
          // row is the row of the piece base (on ground = 0)
          final boardCol = col + px;
          final boardRow = row + (piece.height - 1 - py);

          // Mark the cell as occupied
          if (boardRow >= 0 &&
              boardRow < newGrid.length &&
              boardCol >= 0 &&
              boardCol < cols) {
            newGrid[boardRow][boardCol] = 1;
          }
        }
      }
    }

    // Create a copy of placed pieces and add the new one with position set
    final newPlacedPieces = List<Piece>.from(placedPieces);
    final placedPiece = piece.copyWith(x: col, y: row);
    newPlacedPieces.add(placedPiece);

    // Return a new Board with the updated pieces and grid
    return Board(cols: cols, placedPieces: newPlacedPieces, grid: newGrid);
  }

  /// Returns a visual representation of the grid with rows inverted.
  /// Row 0 (ground) appears at the bottom, matching the board's coordinate system.
  String toStringGrid() {
    if (grid.isEmpty) return 'Empty board';

    // Invert rows: grid[0] is top in internal representation, but row 0 is ground (bottom)
    final invertedGrid = grid.reversed.toList();
    return invertedGrid.map((row) => row.toString()).join('\n');
  }

  @override
  String toString() {
    return 'Board(cols: $cols, rows: $rows, placedPieces: ${placedPieces.length})\n'
        'Grid (row 0 = ground at bottom):\n'
        '${toStringGrid()}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Board &&
        other.cols == cols &&
        other.rows == rows &&
        other.placedPieces.length == placedPieces.length &&
        other.grid == grid;
  }

  @override
  int get hashCode =>
      cols.hashCode ^
      rows.hashCode ^
      placedPieces.length.hashCode ^
      grid.hashCode;

  Board copyWith({
    int? cols,
    List<Piece>? placedPieces,
    List<List<int>>? grid,
  }) {
    return Board(
      cols: cols ?? this.cols,
      placedPieces: placedPieces ?? this.placedPieces,
      grid: grid ?? this.grid,
    );
  }
}
