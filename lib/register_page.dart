import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/common/theme_helper.dart';
import 'package:project/login_page.dart';
import 'package:project/pages/widgets/header_widget.dart';

import 'authentication_service.dart';

class RegisterPage extends StatefulWidget {

  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final double _headerHeight = 250;

  final Key _formKey = GlobalKey<FormState>();

  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final List<String> _dropDownData = [
    'Selecione ..',
    'Diretor Executivo',
    'Supervisor',
    'Operador'
  ];

  String _currentValue = 'Selecione ..';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: _headerHeight,
            child: HeaderWidget(
                _headerHeight, true, Icons.person_add_alt_1_rounded),
          ),
          SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      const Text(
                        'Cadastre-se',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Para ter acesso à plataforma',
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
                              onChanged: (userInput) {},
                              controller: userController,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Usuário', 'Digite um usuário ou apelido'),
                            ),
                            const SizedBox(height: 30),
                            TextField(
                              onChanged: (emailInput) { },
                              controller: emailController,
                              decoration: ThemeHelper().textInputDecoration(
                                  'E-mail', 'Digite seu e-mail'),
                            ),
                            const SizedBox(height: 30),
                            TextField(
                                onChanged: (passInput) {},
                              controller: passController,
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration(
                                    'Senha', 'Inisira sua senha')),
                            const SizedBox(height: 15),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: _currentValue,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 14,
                                  style: const TextStyle(
                                      color: Colors.black54),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _currentValue = newValue!;
                                    });
                                  },
                                  items: _dropDownData
                                      .map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Text(dropDownStringItem),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    UserCredential? userCredential = await
                                    AuthenticationService(
                                      FirebaseAuth.instance,
                                    ).signUp(email: emailController.text.trim(), password: passController.text.trim());
                                    userCredential?.user?.uid;
                                    if(userCredential == null) {
                                      _dialogAlert('Opss!', 'Ocorreu algum erro!');
                                      return;
                                    }
                                    saveData(userCredential.user!.uid);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const LoginPage()),
                                    );
                                  },
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      'confirmar'.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  )))
        ]),
      ),
    );
  }
  saveData(String uuid) {
    FirebaseFirestore.instance.collection('userData').doc(uuid).set({
      'user': userController.text.trim(),
      'cargo': _currentValue
    });
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
