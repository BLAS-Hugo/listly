import 'package:listly/core/database/sembast/sembast_service.dart';
import 'package:listly/features/shopping_list/domain/repositories/shopping_list_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:sembast/sembast.dart';

// Generate mocks
@GenerateMocks(
  [Database, SembastService, ShoppingListRepository],
  customMocks: [
    MockSpec<Database>(as: #MockDatabaseImpl),
    MockSpec<SembastService>(as: #MockSembastServiceImpl),
    MockSpec<ShoppingListRepository>(as: #MockShoppingListRepositoryImpl),
  ],
)
class MockHelpers {}
