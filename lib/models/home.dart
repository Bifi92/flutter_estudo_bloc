class HomeModel {
  late int id;

  late String nome;

  late double valor;

  late bool ativo;

  HomeModel({this.id = 0, this.nome = "", this.valor = 0, this.ativo = false});

  @override
  String toString() {
    return 'id:$id ; nome:$nome ; valor:$valor ; ativo:$ativo';
  }

  static Map<String, Object?> toMap(HomeModel homeModel) {
    final Map<String, dynamic> map = {};
    map["id"] = homeModel.id;
    map["nome"] = homeModel.nome;
    map["valor"] = homeModel.valor;
    map["ativo"] = homeModel.ativo;
    return map;
  }

  static List<HomeModel> toList(List<Map<String, dynamic>> result) {
    final List<HomeModel> homeModel = [];
    for (Map<String, dynamic> map in result) {
      final HomeModel pagamento = HomeModel(
        id: map["id"],
        nome: map["nome"],
        valor: map["valor"],
        ativo: map["ativo"],
      );
      homeModel.add(pagamento);
    }
    return homeModel;
  }
}
