import 'package:google_fonts/google_fonts.dart';
import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';

class CardTaskFinished extends StatefulWidget {
  CardTaskFinished({Key? key}) : super(key: key);

  @override
  _CardTaskFinishedState createState() => _CardTaskFinishedState();
}

class _CardTaskFinishedState extends State<CardTaskFinished> {
  double _taskAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: SizedBox(
          child: InkWell(
            onTap: (){
              _showDialog();
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
                      leading: Image.asset('assets/images/lista-afazeres.png'),
                      title: Text('Tarefas Concluídas'
                        ,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.black45),
                      ),
                      subtitle: Text(_taskAmount.toStringAsFixed(0),
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
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AnimatedCard(
          direction: AnimatedCardDirection.bottom,
          duration: const Duration(milliseconds: 350),
          child: AlertDialog(

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text("Conclusão de Tarefa", style: GoogleFonts.roboto(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black)),
            content: Text("Deseja concluir mais uma tarefa?", style: GoogleFonts.roboto(fontSize: 15, color: Colors.black),),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _taskAmount++;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Concluir',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 0, 158, 0),
                    onPrimary: const Color.fromARGB(255, 255, 255, 255)),
              ),
              TextButton(
                child: const Icon(Icons.close, color: Colors.red,),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
