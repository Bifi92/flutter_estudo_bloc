import 'package:estudo_bloc/bloc/home.dart';
import 'package:estudo_bloc/models/home.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = HomeBloc();

    remove(HomeModel homeModel) {
      homeBloc.salvarModel(homeModel);
      homeBloc.remove();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: StreamBuilder(
        stream: homeBloc.outModelList,
        initialData: homeBloc.modelListlValue,
        builder: (context, AsyncSnapshot<List<HomeModel>> snapshot) {
          homeBloc.carregaModelList();
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Nada encontrado"),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                final HomeModel homeModel = snapshot.data!.elementAt(index);
                return ListTile(
                  title: Text(homeModel.nome),
                  subtitle: Text(
                    homeModel.toString(),
                  ),
                  trailing: IconButton(
                    onPressed: () => remove(homeModel),
                    icon: const Icon(Icons.delete_forever_rounded),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => {
          Navigator.pushNamed(
            context,
            '/cadastro',
          )
        },
      ),
    );
  }
}
