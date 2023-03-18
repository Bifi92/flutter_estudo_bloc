import 'package:estudo_bloc/bloc/home.dart';
import 'package:estudo_bloc/models/home.dart';
import 'package:flutter/material.dart';

class CadastroHomeScreen extends StatelessWidget {
  const CadastroHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final HomeBloc homeBloc = HomeBloc();

    salvar() {
      if (formKey.currentState!.validate()) {
        formKey.currentState?.save();
        homeBloc.add();
        homeBloc.reset();
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Nome",
                      border: UnderlineInputBorder(),
                    ),
                    onSaved: (newValue) {
                      homeBloc.salvarNome(newValue.toString());
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Valor",
                      border: UnderlineInputBorder(),
                    ),
                    onSaved: (newValue) {
                      final double? valor =
                          double.tryParse(newValue.toString());
                      homeBloc.salvarValor(valor!);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text('Ativo?'),
                      StreamBuilder<bool>(
                        stream: homeBloc.outAtivo,
                        initialData: false,
                        builder: (context, snapshot) {
                          return Switch(
                            value: snapshot.data!,
                            onChanged: (value) {
                              homeBloc.salvarAtivo(value);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                      color: Colors.lightBlue,
                      onPressed: () {
                        salvar();
                      },
                      child: const Text("Ok")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
