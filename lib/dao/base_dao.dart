import 'package:estudo_bloc/dao/home.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BaseDao {
  Future<Database> getDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, 'estudo_bloc.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(HomeDao.tableSql);
      },
      version: 1,
    );
  }
}
