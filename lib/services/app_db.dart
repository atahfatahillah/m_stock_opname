import 'dart:async';
import 'package:floor/floor.dart';
import 'package:m_stock_opname/dao/trans_opname_dao.dart';
import 'package:m_stock_opname/dao/users_dao.dart';
import 'package:m_stock_opname/entities/items.dart';
import 'package:m_stock_opname/entities/trans_opname.dart';
import 'package:m_stock_opname/entities/users.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/items_dao.dart';

part 'app_db.g.dart';

@Database(version: 1, entities: [Items, Users, TransOpname])
abstract class AppDB extends FloorDatabase {
  ItemsDao get itemsDao;
  UsersDao get usersDao;
  TransOpnameDao get transOpnameDao;
}
