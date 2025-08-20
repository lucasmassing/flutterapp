import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  @override
  void initState() {
    userList = fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de usuários")),
      body: FutureBuilder(
        future: userList, 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return buildListViewUsers(snapshot.data);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormUserPage(), // rota criada para puxar no cadastro de novos usuários
            )
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildListViewUsers(userList){
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
                    onPressed: (context) {},
                    icon: Icons.edit,
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.black,
                    label: "Editar",
                  ),
                  SlidableAction(
                    onPressed: (context) {},
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    label: "Excluir",
                  ),
                ],
              ),
              child: ListTile(
                leading: const CircleAvatar(child: Text("US")),
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
