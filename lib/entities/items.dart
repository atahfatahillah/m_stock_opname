import 'package:floor/floor.dart';

@Entity(tableName: 'items', indices: [
  Index(value: ['code'], unique: true)
])
class Items {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? code;
  final String? name;
  final String? description;

  Items({this.id, this.code, this.name, this.description});
}
