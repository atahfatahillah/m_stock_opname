import 'package:m_stock_opname/entities/items.dart';
import 'package:floor/floor.dart';

@dao
abstract class ItemsDao {
  @Query('SELECT * FROM items')
  Future<List<Items>> finalAllItems();

  @Query('SELECT * FROM items WHERE code = :code')
  Stream<Items?> findItemsByCode(String code);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertItems(Items items);

  @Query('DELETE FROM items WHERE code = :code')
  Future<void> delete(String code);
}
