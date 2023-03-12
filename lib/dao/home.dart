import 'package:estudo_bloc/dao/base_dao.dart';
import 'package:estudo_bloc/models/home.dart';
import 'package:sqflite/sqflite.dart';

class HomeDao {
  static const _tableName = 'home';
  static const _id = 'id';
  static const _nome = 'nome';
  static const _valor = 'valor';
  static const _ativo = 'ativo';

  static const String tableSql = 'CREATE TABLE $_tableName ('
      '$_id INTEGER PRIMARY KEY, '
      '$_nome TEXT, '
      '$_valor REAL, '
      '$_ativo INTEGER )';

  Future<List<HomeModel>> findAll() async {
    final Database db = await BaseDao().getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<HomeModel> models = HomeModel.toList(result);
    return models;
  }

  Future<int> delete(HomeModel model) async {
    final Database db = await BaseDao().getDatabase();
    return db.delete(
      _tableName,
      where: 'id=?',
      whereArgs: [model.id],
    );
  }

  Future<int> insert(HomeModel model) async {
    final Database db = await BaseDao().getDatabase();
    Map<String, dynamic> modelMap = HomeModel.toMap(model);
    return db.insert(_tableName, modelMap);
  }

  edit(HomeModel model) async {
    final Database db = await BaseDao().getDatabase();
    Map<String, dynamic> pagamentoMap = HomeModel.toMap(model);
    db.update(_tableName, pagamentoMap, where: 'id=?', whereArgs: [model.id]);
  }
}
