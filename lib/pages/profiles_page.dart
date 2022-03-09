import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/login_page.dart';
import 'package:project/pages/splash_screen.dart';
import 'package:project/pages/widgets/card_sellers.dart';
import 'package:project/pages/widgets/card_task_finished.dart';
import 'package:project/pages/widgets/header_widget.dart';
import 'package:project/pages/widgets/line_graph.dart';
import 'package:project/pages/widgets/simple_card.dart';

import '../authentication_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {

  final double _drawerIconSize = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Profile Page',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor
              ])),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              top: 16,
              right: 16,
            ),
            child: Stack(
              children: <Widget>[
                const Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: const Text(
                      '5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, 1],
                  colors: [
                Theme.of(context).primaryColor.withOpacity(0.2),
                Theme.of(context).accentColor.withOpacity(0.5)
              ])),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    "Your Go Plans",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.screen_lock_landscape_rounded, size: _drawerIconSize, color: Theme.of(context).accentColor),
                  title: Text('Splash Screen', style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor),),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreenPage(title: 'Splash Screen page')));
                  },

              ),
               ListTile(
                leading: Icon(Icons.close, size: _drawerIconSize, color: Theme.of(context).accentColor),
                title: Text('Deslogar', style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor),),
                onTap: () async {
                 await AuthenticationService(
                    FirebaseAuth.instance,
                  ).logOut();
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                },
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 100, child: const HeaderWidget(100, false, Icons.house_rounded),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(5, 5),)
                      ]
                    ),
                    child: Icon(Icons.person, size:80, color: Colors.grey.shade300),
                  ),
                  const SizedBox(height: 20,),
                  const Text('Isaac Souza', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  const Text('Mobile Developer', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  SizedBox(
                      child: CardTaskFinished()
                  ),
                  const SizedBox(child: CardSellers(),),
                  Row(
                    children: [
                      SimpleCard(title: 'Geral', subtitle: 'Imagens, Videos', currentIcon: Icons.settings, colorIcon: Colors.red),
                      SimpleCard(title: 'Notification', subtitle: 'All', currentIcon: Icons.notifications, colorIcon: Colors.orange),
                    ],
                  ),
                  const SizedBox(
                    child: LineGraph(),
                  )
                ]
                ),
            )
          ],
        ),
      ),
    );
  }
}
