import 'package:flutter_test/flutter_test.dart';
import 'package:blockin/app/board/domain/model/board.dart';
import 'package:blockin/app/board/domain/model/piece.dart';
import 'package:blockin/app/board/domain/model/piece_skin.dart';
import 'package:flutter/material.dart';

void main() {
  group('Board.canPlacePiece', () {
    test('should allow placing piece on empty ground', () {
      // Board: 4 rows x 12 cols (all empty)
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      //
      // Piece (1x1 block):
      // [1]
      final board = Board(cols: 12);
      final piece = Piece(
        shape: [
          [1],
        ],
        skin: PieceSkin.color(Colors.red),
      );

      expect(board.canPlacePiece(piece, 0, 0, 4), isTrue);
    });

    test('should allow placing piece on ground at different positions', () {
      // Board: 4 rows x 12 cols (all empty)
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      //
      // Piece (1x1 block):
      // [1]
      final board = Board(cols: 12);
      final piece = Piece(
        shape: [
          [1],
        ],
        skin: PieceSkin.color(Colors.red),
      );

      expect(board.canPlacePiece(piece, 0, 5, 4), isTrue);
      expect(board.canPlacePiece(piece, 0, 11, 4), isTrue);
    });

    test('should reject piece placed outside horizontal boundaries (left)', () {
      // Board: 4 rows x 12 cols
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // ...
      //
      // Piece (2x1 horizontal):
      // [1 1]
      final board = Board(cols: 12);
      final piece = Piece(
        shape: [
          [1, 1],
        ],
        skin: PieceSkin.color(Colors.red),
      );

      expect(board.canPlacePiece(piece, 0, -1, 4), isFalse);
    });

    test('should reject piece placed outside horizontal boundaries (right)', () {
      // Board: 4 rows x 12 cols
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // ...
      //
      // Piece (2x1 horizontal):
      // [1 1]
      final board = Board(cols: 12);
      final piece = Piece(
        shape: [
          [1, 1],
        ],
        skin: PieceSkin.color(Colors.red),
      );

      // Placing at col 11 would make the piece extend to col 12 (out of bounds)
      expect(board.canPlacePiece(piece, 0, 11, 4), isFalse);
    });

    test('should reject piece placed outside vertical boundaries (above)', () {
      // Board: 4 rows x 12 cols
      // [0 0 0 0 0 0 0 0 0 0 0 0]  row 3
      // [0 0 0 0 0 0 0 0 0 0 0 0]  row 2
      // [0 0 0 0 0 0 0 0 0 0 0 0]  row 1
      // [0 0 0 0 0 0 0 0 0 0 0 0]  row 0 (ground)
      //
      // Piece (2x2 block):
      // [1 1]
      // [1 1]
      final board = Board(cols: 12);
      final piece = Piece(
        shape: [
          [1, 1],
          [1, 1],
        ],
        skin: PieceSkin.color(Colors.red),
      );

      // Placing at row 3 would make the piece extend to row 4 (out of bounds for totalRows=4)
      expect(board.canPlacePiece(piece, 3, 0, 4), isFalse);
    });

    test(
      'should reject piece placed outside vertical boundaries (below ground)',
      () {
        // Board: 4 rows x 12 cols
        // ...
        //
        // Piece (1x1 block):
        // [1]
        final board = Board(cols: 12);
        final piece = Piece(
          shape: [
            [1],
          ],
          skin: PieceSkin.color(Colors.red),
        );

        expect(board.canPlacePiece(piece, -1, 0, 4), isFalse);
      },
    );

    test('should reject piece that overlaps with occupied cells', () {
      // Board with one piece at (0, 0):
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [1 0 0 0 0 0 0 0 0 0 0 0]  row 0 (ground) - occupied
      //
      // Piece (1x1 block):
      // [1]
      final board = Board(
        cols: 12,
        grid: [
          [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        ],
      );
      final piece = Piece(
        shape: [
          [1],
        ],
        skin: PieceSkin.color(Colors.red),
      );

      expect(board.canPlacePiece(piece, 0, 0, 4), isFalse);
    });

    test('should allow placing piece above existing piece (with support)', () {
      // Board with one piece at (0, 0):
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [1 0 0 0 0 0 0 0 0 0 0 0]  row 1 - occupied
      // [1 0 0 0 0 0 0 0 0 0 0 0]  row 0 (ground) - occupied
      //
      // Piece (1x1 block):
      // [1]
      final board = Board(
        cols: 12,
        grid: [
          [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        ],
      );
      final piece = Piece(
        shape: [
          [1],
        ],
        skin: PieceSkin.color(Colors.red),
      );

      // Can place at row 2 (above the existing piece at row 1)
      expect(board.canPlacePiece(piece, 2, 0, 4), isTrue);
    });

    test('should reject piece placed in mid-air without support', () {
      // Board with one piece at (2, 0):
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 1 0 0 0 0 0 0 0 0 0]  row 1 - occupied
      // [0 0 1 0 0 0 0 0 0 0 0 0]  row 0 (ground) - occupied
      //
      // Piece (1x1 block):
      // [1]
      final board = Board(
        cols: 12,
        grid: [
          [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        ],
      );
      final piece = Piece(
        shape: [
          [1],
        ],
        skin: PieceSkin.color(Colors.red),
      );

      // Cannot place at row 1, col 0 (no support below)
      expect(board.canPlacePiece(piece, 1, 0, 4), isFalse);
    });

    test(
      'should allow placing horizontal piece with at least one base cell on ground',
      () {
        // Board: 4 rows x 12 cols (all empty)
        // [0 0 0 0 0 0 0 0 0 0 0 0]
        // [0 0 0 0 0 0 0 0 0 0 0 0]
        // [0 0 0 0 0 0 0 0 0 0 0 0]
        // [0 0 0 0 0 0 0 0 0 0 0 0]
        //
        // Piece (3x1 horizontal line):
        // [1 1 1]
        final board = Board(cols: 12);
        final piece = Piece(
          shape: [
            [1, 1, 1],
          ],
          skin: PieceSkin.color(Colors.red),
        );

        expect(board.canPlacePiece(piece, 0, 0, 4), isTrue);
      },
    );

    test('should allow placing L-shaped piece with support', () {
      // Board with one piece at (0, 0):
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [1 0 0 0 0 0 0 0 0 0 0 0]  row 1 - occupied
      // [1 0 0 0 0 0 0 0 0 0 0 0]  row 0 (ground) - occupied
      //
      // Piece (L-shape, 2x2):
      // [1 0]
      // [1 1]
      final board = Board(
        cols: 12,
        grid: [
          [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        ],
      );
      final piece = Piece(
        shape: [
          [1, 0],
          [1, 1],
        ],
        skin: PieceSkin.color(Colors.red),
      );

      // Can place at row 2, col 0 (left column has support from existing piece)
      expect(board.canPlacePiece(piece, 2, 0, 4), isTrue);
    });

    test('should reject L-shaped piece without support', () {
      // Board with one piece at (2, 0):
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 1 0 0 0 0 0 0 0 0 0]  row 1 - occupied
      // [0 0 1 0 0 0 0 0 0 0 0 0]  row 0 (ground) - occupied
      //
      // Piece (L-shape, 2x2):
      // [1 0]
      // [1 1]
      final board = Board(
        cols: 12,
        grid: [
          [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        ],
      );
      final piece = Piece(
        shape: [
          [1, 0],
          [1, 1],
        ],
        skin: PieceSkin.color(Colors.red),
      );

      // Cannot place at row 1, col 0 (no support for left column)
      expect(board.canPlacePiece(piece, 1, 0, 4), isFalse);
    });

    test('should allow placing tall piece on ground', () {
      // Board: 4 rows x 12 cols (all empty)
      // [0 0 0 0 0 0 0 0 0 0 0 0]  row 3
      // [0 0 0 0 0 0 0 0 0 0 0 0]  row 2
      // [0 0 0 0 0 0 0 0 0 0 0 0]  row 1
      // [0 0 0 0 0 0 0 0 0 0 0 0]  row 0 (ground)
      //
      // Piece (1x3 vertical line):
      // [1]
      // [1]
      // [1]
      final board = Board(cols: 12);
      final piece = Piece(
        shape: [
          [1],
          [1],
          [1],
        ],
        skin: PieceSkin.color(Colors.red),
      );

      expect(board.canPlacePiece(piece, 0, 0, 4), isTrue);
    });

    test('should allow placing piece with partial support', () {
      // Board with pieces creating a step:
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [1 1 0 0 0 0 0 0 0 0 0 0]  row 1 - occupied
      // [1 1 0 0 0 0 0 0 0 0 0 0]  row 0 (ground) - occupied
      //
      // Piece (2x1 horizontal):
      // [1 1]
      final board = Board(
        cols: 12,
        grid: [
          [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        ],
      );
      final piece = Piece(
        shape: [
          [1, 1],
        ],
        skin: PieceSkin.color(Colors.red),
      );

      // Can place at row 2, col 0 (left cell has support, right cell doesn't need it)
      expect(board.canPlacePiece(piece, 2, 0, 4), isTrue);
    });

    test(
      'should reject piece that would overlap with existing piece above ground',
      () {
        // Board with pieces:
        // [0 0 0 0 0 0 0 0 0 0 0 0]
        // [1 1 0 0 0 0 0 0 0 0 0 0]  row 2 - occupied
        // [1 1 0 0 0 0 0 0 0 0 0 0]  row 1 - occupied
        // [1 1 0 0 0 0 0 0 0 0 0 0]  row 0 (ground) - occupied
        //
        // Piece (2x1 horizontal):
        // [1 1]
        final board = Board(
          cols: 12,
          grid: [
            [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          ],
        );
        final piece = Piece(
          shape: [
            [1, 1],
          ],
          skin: PieceSkin.color(Colors.red),
        );

        // Cannot place at row 1, col 0 (would overlap with existing piece at row 2)
        expect(board.canPlacePiece(piece, 1, 0, 4), isFalse);
      },
    );

    test('should handle T-shaped piece placement', () {
      // Board: 4 rows x 12 cols (all empty)
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      // [0 0 0 0 0 0 0 0 0 0 0 0]
      //
      // Piece (T-shape, 2x2):
      // [1 1]
      // [0 1]
      final board = Board(cols: 12);
      final piece = Piece(
        shape: [
          [1, 1],
          [0, 1],
        ],
        skin: PieceSkin.color(Colors.red),
      );

      expect(board.canPlacePiece(piece, 0, 0, 4), isTrue);
    });

    test(
      'should allow placing piece in virtual rows above current grid with support',
      () {
        // Board: 2 rows x 12 cols (current grid)
        // [1 0 0 0 0 0 0 0 0 0 0 0]  row 1 - occupied (provides support for row 2)
        // [1 0 0 0 0 0 0 0 0 0 0 0]  row 0 (ground) - occupied
        //
        // Piece (1x1 block):
        // [1]
        final board = Board(
          cols: 12,
          grid: [
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          ],
        );
        final piece = Piece(
          shape: [
            [1],
          ],
          skin: PieceSkin.color(Colors.red),
        );

        // Can place in virtual row 2 (above current grid, but within totalRows=4)
        // Has support from the piece at row 1
        expect(board.canPlacePiece(piece, 2, 0, 4), isTrue);
      },
    );

    test('should reject piece without support at the bottom', () {
      // Initial board:
      final initialBoard = Board(
        cols: 12,
        grid: [
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        ],
      );

      final firstPiece = Piece(
        shape: [
          [0, 1, 0],
          [1, 1, 1],
        ],
        skin: PieceSkin.color(Colors.red),
      );

      final boardWithFirstPiece = initialBoard.placePiece(firstPiece, 0, 6, 4);

      final piece = Piece(
        shape: [
          [1, 1, 1],
          [0, 1, 0],
        ],
        skin: PieceSkin.color(Colors.red),
      );

      // Cannot place (no support)
      expect(boardWithFirstPiece?.canPlacePiece(piece, 2, 5, 4), isFalse);
    });
  });
}
