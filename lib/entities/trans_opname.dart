import 'package:floor/floor.dart';

@Entity(tableName: 'trans_opname')
class TransOpname {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String code;
  final int qty;
  final String uom;
  @ColumnInfo(name: 'created_at')
  final String createdAt;
  @ColumnInfo(name: 'updated_at')
  final String updatedAt;

  TransOpname({
    this.id,
    required this.code,
    required this.qty,
    required this.uom,
    required this.createdAt,
    required this.updatedAt,
  });
}
