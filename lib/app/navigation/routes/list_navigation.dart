import 'package:go_router/go_router.dart';
import 'package:listly/features/shopping_list/presentation/views/debug_screen.dart';

/// List tab routes
final listHome = GoRoute(
  path: '/',
  name: 'list-home',
  builder: (context, state) => const DebugScreen(title: 'Listes'),
);

// Add more list routes here as you develop
// Example:
// final listDetail = GoRoute(
//   path: '/list/:id',
//   name: 'list-detail',
//   builder: (context, state) {
//     final id = state.pathParameters['id']!;
//     return ListDetailScreen(listId: id);
//   },
// );
