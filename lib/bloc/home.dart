import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:estudo_bloc/dao/home.dart';
import 'package:estudo_bloc/models/home.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  HomeDao databaseHelper = HomeDao();

  @override
  void dispose() {
    _id.close();
    _nome.close();
    _valor.close();
    _ativo.close();
    _model.close();
    _modelList.close();
    super.dispose();
  }

  //id >>>>>
  final _id = BehaviorSubject<int>.seeded(0);

  Stream<int> get outId => _id.stream;

  Sink<int> get inId => _id.sink;

  int get idValue => _id.value;

  void salvarId(int id) {
    inId.add(id);
  }
  //<<<<< id

  //nome >>>>>
  final _nome = BehaviorSubject<String>.seeded("");

  Stream<String> get outNome => _nome.stream;

  Sink<String> get inNome => _nome.sink;

  String get nomeValue => _nome.value;

  void salvarNome(String nome) {
    inNome.add(nome);
  }
  //<<<<< nome

  //valor >>>>>
  final _valor = BehaviorSubject<double>.seeded(0);

  Stream<double> get outValor => _valor.stream;

  Sink<double> get inValor => _valor.sink;

  double get valorValue => _valor.value;

  void salvarValor(double valor) {
    inValor.add(valor);
  }
  //<<<<< valor

  //ativo >>>>>
  final _ativo = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get outAtivo => _ativo.stream;

  Sink<bool> get inAtivo => _ativo.sink;

  bool get ativoValue => _ativo.value;

  void salvarAtivo(bool ativo) {
    inAtivo.add(ativo);
  }
  //<<<<< ativo

  //model >>>>>
  final _model = BehaviorSubject<HomeModel>.seeded(HomeModel());

  Stream<HomeModel> get outModel => _model.stream;

  Sink<HomeModel> get inModel => _model.sink;

  HomeModel get modelValue => _model.value;

  void salvarModel(HomeModel model) {
    inModel.add(model);
  }
  //<<<<< model

  //modelList >>>>>
  final _modelList = BehaviorSubject<List<HomeModel>>.seeded(<HomeModel>[]);

  Stream<List<HomeModel>> get outModelList => _modelList.stream;

  Sink<List<HomeModel>> get inModelList => _modelList.sink;

  List<HomeModel> get modelListlValue => _modelList.value;

  void salvarModelList(List<HomeModel> modelList) {
    inModelList.add(modelList);
  }

  void carregaModelList() async {
    List<HomeModel> modelList = await databaseHelper.findAll();
    modelList.sort((a, b) {
      return a.nome.toLowerCase().compareTo(b.nome.toLowerCase());
    });
    _modelList.value = modelList;
  }
  //<<<<< modelList

  void add() {
    HomeModel value = HomeModel(
        id: idValue, nome: nomeValue, ativo: ativoValue, valor: valorValue);
    databaseHelper.insert(value);
    modelListlValue.add(value);
    modelListlValue.sort((a, b) {
      return a.nome.toLowerCase().compareTo(b.nome.toLowerCase());
    });
    inModelList.add(modelListlValue);
    if (kDebugMode) {
      print("salva lista");
    }
  }

  void remove() {
    databaseHelper.delete(modelValue);
    modelListlValue.remove(modelValue);
    inModelList.add(modelListlValue);
    if (kDebugMode) {
      print("remove lista");
    }
  }

  void reset() {
    salvarNome("");
    salvarAtivo(false);
    salvarId(0);
    salvarValor(0);
    salvarModel(HomeModel());
  }
}
