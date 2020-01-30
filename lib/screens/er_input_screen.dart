import 'package:automatas/screens/er_results.dart';
import 'package:flutter/material.dart';
import 'package:automatas/components/fondo_component.dart';

class ERInputPage extends StatefulWidget {
  ERInputPage({Key key}) : super(key: key);
  @override
  _ERInputPageState createState() => _ERInputPageState();
}

class _ERInputPageState extends State<ERInputPage> {
  String _expresionRegular = "";
  TextEditingController _inputCtrl = TextEditingController();
  double ancho;
  double alto;
  @override
  Widget build(BuildContext context) {
    ancho = MediaQuery.of(context).size.width;
    alto = MediaQuery.of(context).size.height;
    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            FondoComponent(),
            _titulo(),
          ],
        ),
      ),
    );
  }

  void goToResult() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultsER(
                  infija: _expresionRegular,
                )));
  }

  Widget _titulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: 'er',
              child: Text(
                "Expresiones Regulares",
                style: TextStyle(
                    fontSize: ancho * 0.07,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: alto * 0.02,
            ),
            Container(
                padding: EdgeInsets.only(left: ancho * 0.1),
                child: Column(
                  children: <Widget>[
                    infoOperador("+", "Unión o alternativa"),
                    infoOperador(".", "Concatenación"),
                    infoOperador("*", "Cierre u operación estrella"),
                  ],
                )),
            SizedBox(
              height: alto * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.help,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () {
                    _inputCtrl.text += '?';
                  },
                  color: Colors.orangeAccent,
                )
              ],
            ),
            TextField(
              controller: _inputCtrl,
              autofocus: true,
              decoration: InputDecoration(
                  hintText: 'Escriba aquí la expresión regular',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide:
                        BorderSide(color: Colors.orangeAccent, width: 1.0),
                  )),
              cursorColor: Colors.white,
              obscureText: false,
              onChanged: (value) {
                print(value);
                _expresionRegular = value;
              },
              //autofocus: true,
              onSubmitted: (value) {
                goToResult();
              },
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Row infoOperador(String operador, String info) {
    return Row(
      children: <Widget>[
        Text(
          operador,
          style: TextStyle(
            color: Colors.white,
            fontSize: ancho * 0.07,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: alto * 0.04,
        ),
        Text(
          info,
          style: TextStyle(
            color: Colors.white,
            fontSize: ancho * 0.04,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
