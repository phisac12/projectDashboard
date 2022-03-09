import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/login_page.dart';

class SplashScreenPage extends StatefulWidget {
  String title;
  SplashScreenPage({Key? key, required this.title}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool _isVisible = false;

  _SplashScreenPageState() {
    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      });
    });

    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor
            ],
            begin: const FractionalOffset(0, 0),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0,
          duration: const Duration(milliseconds: 1200),
          child: Center(
            child: Container(
              height: 140.0,
              width: 140.0,
              child: const Center(
                child: ClipOval(
                  child: Icon(Icons.android_outlined, size: 128),
                ),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2.0,
                      offset: const Offset(5.0, 3.0),
                      spreadRadius: 2.0,
                    )
                  ]),
            ),
          ),
        ));
  }
}
