import 'package:flutter/material.dart';
import 'package:flutterapp/models/user_model.dart';
import 'package:flutterapp/repositories/users_repository.dart';

class FormUserPage extends StatefulWidget {
  const FormUserPage({super.key});

  @override
  State<FormUserPage> createState() => _FormUserPageState();
}

class _FormUserPageState extends State<FormUserPage> {
  TextEditingController txtNameController = TextEditingController();
  TextEditingController txtEmailController = TextEditingController();
  TextEditingController txtPhotoController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  //instanciar o repositório
  final repository = UsersRepository();
  saveUser() async {
    try {
      //criar o UserModel a partir dos dados do formulário
      UserModel userModel = UserModel(
        name: txtNameController.text,
        email: txtEmailController.text,
        avatar: txtPhotoController.text,
      );
      //salvar o usuário no banco
      await repository.postNewUser(userModel);
      //mostrar mensagem de sucesso
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Dados salvos!')));
      //voltar para a tela anterior
      Navigator.pop(context);
    } catch (e) {
      //mostrar mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulário usuário")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  // value é o valor digitado no TextFormField
                  if (value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
                controller: txtNameController,
                decoration: InputDecoration(hintText: "Preencha o nome"),
              ),
              TextFormField(
                validator: (value) {
                  // value é o valor digitado no TextFormField
                  if (value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
                controller: txtEmailController,
                decoration: InputDecoration(hintText: "Preencha o email"),
              ),
              TextFormField(
                validator: (value) {
                  // value é o valor digitado no TextFormField
                  if (value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
                controller: txtPhotoController,
                decoration: InputDecoration(hintText: "Preencha a foto"),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    // vai validar todos os validators do FormTextField
                    // pegar os valores e salvar no DB
                    saveUser();
                  }
                },
                child: Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
