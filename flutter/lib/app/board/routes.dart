import 'package:go_router/go_router.dart';
import 'package:blockin/app/board/ui/screens/home_screen.dart';

final boardRoutes = [
  GoRoute(
    path: TetrisDemoScreen.routeName,
    builder: (context, state) => TetrisDemoScreen(),
  ),
];
