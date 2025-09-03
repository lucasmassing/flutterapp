import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterapp/components/menu.dart';
import 'package:flutterapp/models/user_model.dart';
import 'package:flutterapp/pages/form_user_page.dart';
import 'package:flutterapp/repositories/users_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = UsersRepository();

  late Future<List<UserModel>> userList;

  Future<List<UserModel>> fetchUsers() async {
    return await repository.getUsers();
  }

  deleteUser(String id) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirmação'),
        content: const Text('Confirma exclusão deste usuário?'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              await repository.deleteUser(id);
              Navigator.pop(context);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );

    //após finalizar a exclusão, atualizar a lista de usuários
    setState(() {
      userList = fetchUsers();
    });
  }

  @override
  void initState() {
    userList = fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de usuários")),
      drawer: Menu(),
      body: FutureBuilder(
        future: userList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum usuário encontrado"));
          } else {
            return buildListViewUsers(snapshot.data);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FormUserPage(), // rota criada para puxar no cadastro de novos usuários
            ),
          );
          setState(() {
            userList = fetchUsers();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildListViewUsers(userList) {
    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          child: Slidable(
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FormUserPage(userEdit: userList[index]),
                      ),
                    );
                    setState(() {
                      userList = fetchUsers();
                    });
                  },

                  icon: Icons.edit,
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                  label: "Editar",
                ),
                SlidableAction(
                  onPressed: (context) {
                    deleteUser(userList[index].id);
                  },
                  icon: Icons.delete,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  label: "Excluir",
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Image.network(userList[index].avatar)),
              title: Text(userList[index].name ?? ''),
              subtitle: Text(userList[index].email ?? ''),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        );
      },
    );
  }
}
