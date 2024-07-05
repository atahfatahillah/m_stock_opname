import 'package:floor/floor.dart';

@Entity(tableName: 'users', indices: [
  Index(value: ['username'], unique: true),
])
class Users {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? username;
  final String? password;
  final String? full_name;

  Users({this.id, this.username, this.password, this.full_name});
}
