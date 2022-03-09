import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project/authentication_service.dart';
import 'package:project/common/theme_helper.dart';
import 'package:project/pages/profiles_page.dart';
import 'package:project/pages/widgets/header_widget.dart';
import 'package:project/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final double _headerHeight = 250;
  final Key _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: _headerHeight,
            child: HeaderWidget(_headerHeight, true, Icons.login_outlined),
          ),
          SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      const Text(
                        'Olá',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Entre com sua conta',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextField(
                              controller: emailController,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Usuário', 'Entre com seu Usuário ou e-mail'),
                            ),
                            const SizedBox(height: 30),
                            TextField(
                              controller: passController,
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration(
                                    'Senha', 'Inisira sua senha')),
                            const SizedBox(height: 15),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                              alignment: Alignment.topRight,
                              child: const Text('Esqueceu sua senha?'),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    var isLogged = await
                                    AuthenticationService(
                                      FirebaseAuth.instance,
                                    ).signIn(email: emailController.text.trim(), password: passController.text.trim());

                                    if(isLogged == 'Logado com sucesso!') {
                                      _dialogAlert('Sucesso!', 'Você foi logado com sucesso!');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const ProfilePage()),
                                      );
                                    } else {
                                      _dialogAlert('Ops!', 'Email ou usuários inválidos!');
                                    }
                                  },
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      'Entre'.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text:'Não tem uma conta? '),
                                    TextSpan(
                                      text: 'Criar conta',
                                      recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                                      },
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)
                                      )
                                  ]
                                )
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )))
        ]),
      ),
    );
  }
   _dialogAlert(String title, String subtitle) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(child: Text(subtitle)),
            actions: <Widget>[
              ElevatedButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              )
            ],
          );
        }
    );
  }
}
