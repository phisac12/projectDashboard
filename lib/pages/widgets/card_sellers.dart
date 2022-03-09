import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_card/animated_card.dart';

class CardSellers extends StatefulWidget {
  const CardSellers({Key? key}) : super(key: key);

  @override
  _CardSellersState createState() => _CardSellersState();
}

class _CardSellersState extends State<CardSellers> {
  TextEditingController moneyController = TextEditingController();
  double amountMoney = 100;
  String newValue = '';

  @override
  void dispose() {
    moneyController.dispose();
    super.dispose();
  }

  void clearText() {
    moneyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              _newValueDialog(amountMoney);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
              ),
              elevation: 15,
              color: Colors.white,
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListTile(
                      leading: Image.asset('assets/images/money.png'),
                      title: Text('Valores do mês',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black45),
                      ),
                      subtitle: Text('\$$amountMoney',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 38,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
   Future _newValueDialog(double money) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        context: context;
        return AnimatedCard(
          direction: AnimatedCardDirection.bottom,
          duration: const Duration(milliseconds: 350),
          child: Column(
            children: [
               AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                title: Text("Deseja inserir um valor?", style: GoogleFonts.roboto(fontSize: 15, color: Colors.black)),
                content: RichText(
                  text: TextSpan(
                    text: 'Saldo atual: ', style: GoogleFonts.roboto(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                    children: [
                      TextSpan(text:'\$$money'),
                    ]
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      child: TextField(
                        onChanged: (moneyValue){
                          newValue = moneyValue;
                        },
                        decoration: const InputDecoration(hintText: 'Digite um novo valor'),
                          keyboardType: TextInputType.number,
                        controller: moneyController,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        amountMoney += double.parse(newValue);
                        clearText();
                        Navigator.of(context).pop();

                      });
                    },
                    child: const Text('Adicionar',
                        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 0, 158, 0),
                        onPrimary: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
