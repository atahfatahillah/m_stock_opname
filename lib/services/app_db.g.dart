// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDBBuilderContract {
  /// Adds migrations to the builder.
  $AppDBBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDBBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDB> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDB {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDBBuilderContract databaseBuilder(String name) =>
      _$AppDBBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDBBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDBBuilder(null);
}

class _$AppDBBuilder implements $AppDBBuilderContract {
  _$AppDBBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDBBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDBBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDB> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDB();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDB extends AppDB {
  _$AppDB([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ItemsDao? _itemsDaoInstance;

  UsersDao? _usersDaoInstance;

  TransOpnameDao? _transOpnameDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `items` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `code` TEXT, `name` TEXT, `description` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `username` TEXT, `password` TEXT, `full_name` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `trans_opname` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `code` TEXT NOT NULL, `qty` INTEGER NOT NULL, `uom` TEXT NOT NULL, `created_at` TEXT NOT NULL, `updated_at` TEXT NOT NULL)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_items_code` ON `items` (`code`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_users_username` ON `users` (`username`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ItemsDao get itemsDao {
    return _itemsDaoInstance ??= _$ItemsDao(database, changeListener);
  }

  @override
  UsersDao get usersDao {
    return _usersDaoInstance ??= _$UsersDao(database, changeListener);
  }

  @override
  TransOpnameDao get transOpnameDao {
    return _transOpnameDaoInstance ??=
        _$TransOpnameDao(database, changeListener);
  }
}

class _$ItemsDao extends ItemsDao {
  _$ItemsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _itemsInsertionAdapter = InsertionAdapter(
            database,
            'items',
            (Items item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'name': item.name,
                  'description': item.description
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Items> _itemsInsertionAdapter;

  @override
  Future<List<Items>> finalAllItems() async {
    return _queryAdapter.queryList('SELECT * FROM items',
        mapper: (Map<String, Object?> row) => Items(
            id: row['id'] as int?,
            code: row['code'] as String?,
            name: row['name'] as String?,
            description: row['description'] as String?));
  }

  @override
  Stream<Items?> findItemsByCode(String code) {
    return _queryAdapter.queryStream('SELECT * FROM items WHERE code = ?1',
        mapper: (Map<String, Object?> row) => Items(
            id: row['id'] as int?,
            code: row['code'] as String?,
            name: row['name'] as String?,
            description: row['description'] as String?),
        arguments: [code],
        queryableName: 'items',
        isView: false);
  }

  @override
  Future<void> delete(String code) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM items WHERE code = ?1', arguments: [code]);
  }

  @override
  Future<void> insertItems(Items items) async {
    await _itemsInsertionAdapter.insert(items, OnConflictStrategy.ignore);
  }
}

class _$UsersDao extends UsersDao {
  _$UsersDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _usersInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (Users item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'password': item.password,
                  'full_name': item.full_name
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Users> _usersInsertionAdapter;

  @override
  Stream<Users?> findUser(String username) {
    return _queryAdapter.queryStream('SELECT * FROM users WHERE username = ?1',
        mapper: (Map<String, Object?> row) => Users(
            id: row['id'] as int?,
            username: row['username'] as String?,
            password: row['password'] as String?,
            full_name: row['full_name'] as String?),
        arguments: [username],
        queryableName: 'users',
        isView: false);
  }

  @override
  Future<void> insertUser(Users users) async {
    await _usersInsertionAdapter.insert(users, OnConflictStrategy.ignore);
  }
}

class _$TransOpnameDao extends TransOpnameDao {
  _$TransOpnameDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _transOpnameInsertionAdapter = InsertionAdapter(
            database,
            'trans_opname',
            (TransOpname item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'qty': item.qty,
                  'uom': item.uom,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TransOpname> _transOpnameInsertionAdapter;

  @override
  Future<List<TransOpname?>> finalAllItems(String createdAt) async {
    return _queryAdapter.queryList(
        'SELECT * FROM trans_opname where created_at = ?1',
        mapper: (Map<String, Object?> row) => TransOpname(
            id: row['id'] as int?,
            code: row['code'] as String,
            qty: row['qty'] as int,
            uom: row['uom'] as String,
            createdAt: row['created_at'] as String,
            updatedAt: row['updated_at'] as String),
        arguments: [createdAt]);
  }

  @override
  Future<TransOpname?> getTransOpname(
    String code,
    String createdAt,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM trans_opname where code = ?1 and created_at = ?2 order by id desc limit 1',
        mapper: (Map<String, Object?> row) => TransOpname(id: row['id'] as int?, code: row['code'] as String, qty: row['qty'] as int, uom: row['uom'] as String, createdAt: row['created_at'] as String, updatedAt: row['updated_at'] as String),
        arguments: [code, createdAt]);
  }

  @override
  Future<void> delete(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM trans_opname WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insert(TransOpname transOpname) async {
    await _transOpnameInsertionAdapter.insert(
        transOpname, OnConflictStrategy.replace);
  }
}
