import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterapp/pages/form_user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> userList = ["user1", "user2", "user3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de usuários")),
      body: ListView.builder(
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
                title: Text(userList[index]),
                subtitle: const Text("email@email.com"),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
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
}
