import 'package:floor/floor.dart';
import 'package:m_stock_opname/entities/users.dart';

@dao
abstract class UsersDao {
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertUser(Users users);

  @Query('SELECT * FROM users WHERE username = :username')
  Stream<Users?> findUser(String username);
}
