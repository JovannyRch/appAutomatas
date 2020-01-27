import 'dart:math';

import 'package:flutter/material.dart';

class FondoComponent extends StatelessWidget {
  const FondoComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _fondo();
  }

  Widget _fondo() {
    final gradiante = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0),
          ],
        ),
      ),
    );

    final caja = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        width: 500,
        height: 360,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.0),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(236, 98, 18, 1.0),
              Color.fromRGBO(241, 142, 17, 1.0),
            ])),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiante,
        Positioned(
          top: -150.0,
          left: -20,
          child: caja,
        ),
      ],
    );
  }
}

class FondoComponent2 extends StatelessWidget {
  const FondoComponent2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _fondo(context);
  }

  Widget _fondo(BuildContext context) {
    final gradiante = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0),
          ],
        ),
      ),
    );

    final caja = Positioned(
        top: -MediaQuery.of(context).size.height / 5,
        left: 0,
        child: Transform.rotate(
          angle: -pi / 1,
          child: Container(
            width: MediaQuery.of(context).size.width * 1.30,
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(220.0),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(236, 98, 18, 1.0),
                  Color.fromRGBO(241, 142, 17, 1.0),
                ])),
          ),
        ));

    return Stack(
      children: <Widget>[
        gradiante,
        caja,
      ],
    );
  }
}
