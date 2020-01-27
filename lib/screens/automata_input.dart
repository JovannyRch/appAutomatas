import 'package:flutter/material.dart';
import 'package:automatas/components/fondo_component.dart';

class AutomataInput extends StatefulWidget {
  AutomataInput({Key key}) : super(key: key);

  @override
  _AutomataInputState createState() => _AutomataInputState();
}

class _AutomataInputState extends State<AutomataInput> {
  @override
  Widget build(BuildContext context) {
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

  Widget _titulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: 'automatas',
              child: Text(
                "Conversiones",
                style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('+'),
                      Text(
                        'Escribe la expresión',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 150.0,
            ),
          ],
        ),
      ),
    );
  }
}
