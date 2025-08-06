import 'package:flutter/material.dart';
import 'package:flutterapp/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // variaveis
  bool showpassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          // logo
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Image.asset("assets/logotipo_firma.png"),
          ),

          // email input
          TextField(
            maxLength: 50,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Informe o e-mail",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(37),
                borderSide: BorderSide.none
              )
            ),
          ),
          
          // password
          TextField(
            // controla as bolinhas ao digitar a senha
            obscureText: showpassword,

            maxLength: 16,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: (){
                  setState(() {
                    showpassword = !showpassword;
                  });
                }, 
                icon: showpassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
              ), // operador ternário
              hintText: "Informe a senha",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(37),
                borderSide: BorderSide.none
              )
            ),
          ),
          
          // btn login
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: (){
                // navegar para home page
                Navigator.pushReplacement (context, MaterialPageRoute(builder: (context) => HomePage()));
              }, 
              child: Text("Entrar")),
          )
        ],
      ),
    );
  }
}