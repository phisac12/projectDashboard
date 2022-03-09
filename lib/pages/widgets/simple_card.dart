import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class SimpleCard extends StatelessWidget {
  String title;
  String subtitle;
  IconData currentIcon;
  Color colorIcon;
  SimpleCard({Key? key, required this.title, required this.subtitle, required this.currentIcon, required this.colorIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 15,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
        ),
        child: Container(
          padding: const EdgeInsets.all(22),
          width: 150,
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  decoration:  BoxDecoration(
                      color: colorIcon,
                      borderRadius: const BorderRadius.all(Radius.circular(100))
                  ),
                  width: 70,
                  height: 70,
                  child: Icon(currentIcon, color: Colors.white, size: 37),
                ),
              ),
              RichText(
                  text: TextSpan(
                      text: '$title\n', style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20.1, color: Colors.black),
                      children: [
                        TextSpan(
                          text: subtitle, style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                        )
                      ]
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
