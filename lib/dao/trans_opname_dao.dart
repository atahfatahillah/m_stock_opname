import 'package:floor/floor.dart';
import 'package:m_stock_opname/entities/trans_opname.dart';

@dao
abstract class TransOpnameDao {
  @Query('SELECT * FROM trans_opname where created_at = :createdAt')
  Future<List<TransOpname?>> finalAllItems(String createdAt);

  @Query(
      'SELECT * FROM trans_opname where code = :code and created_at = :createdAt order by id desc limit 1')
  Future<TransOpname?> getTransOpname(String code, String createdAt);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(TransOpname transOpname);

  @Query('DELETE FROM trans_opname WHERE id = :id')
  Future<void> delete(int id);
}
