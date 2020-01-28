import 'package:flutter/material.dart';
import 'package:automatas/components/fondo_component.dart';
import 'package:flutter/rendering.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class AutomataInput extends StatefulWidget {
  AutomataInput({Key key}) : super(key: key);

  @override
  _AutomataInputState createState() => _AutomataInputState();
}

class _AutomataInputState extends State<AutomataInput> {
  int cantidadEstados = 0;
  List<String> alfabeto = [];
  List<String> estados = [];
  List<String> estadosFinales = [];
  String estadoInicial = "q0";
  double alto;
  double ancho;
  Color naranja = Color.fromRGBO(241, 142, 17, 1.0);
  List<String> qOutput = [];
  SolidController controllerBS = new SolidController();

  Color naranjaOscuro = Color.fromRGBO(236, 98, 18, 1.0);

  Color fondo = Color.fromRGBO(52, 54, 101, 1.0);

  String tituloPrincipal = "Autómata finito reducido";
  int tipoAutomata = 1;
  @override
  Widget build(BuildContext context) {
    alto = MediaQuery.of(context).size.height;
    ancho = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            FondoComponent3(),
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      _titulo(),
                      titulo('Alfabeto'),
                      contenedor(
                        0.75,
                        0.12,
                        TextField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: "Presione aquí para ingresar alfabeto",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            helperText: "Separe el alfabeto con una coma",
                            helperStyle: TextStyle(color: Colors.white),
                          ),
                          onChanged: (valor) {
                            this.alfabeto = valor.split(',');
                          },
                          onSubmitted: (valor) {
                            this.alfabeto = valor.split(',');
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      titulo('# de estados'),
                      contenedor(
                        0.75,
                        0.06,
                        TextField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: "Presione aquí para asignar estados",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onChanged: (valor) {
                            this.cantidadEstados = int.parse(valor);
                            this.generarEstados();
                          },
                          onSubmitted: (valor) {
                            this.cantidadEstados = int.parse(valor);
                            this.generarEstados();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          titulo('Estado'),
                          titulo('¿Es final?'),
                          titulo('¿Es inicial?'),
                        ],
                      ),
                      contenedor(
                        .75,
                        null,
                        Column(
                          children: this
                              .estados
                              .map((q) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        q,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Switch(
                                        value: this.estadosFinales.contains(q),
                                        onChanged: (valor) {
                                          if (valor) {
                                            this.estadosFinales.add(q);
                                          } else {
                                            this.estadosFinales.remove(q);
                                          }
                                          setState(() {});
                                        },
                                        activeColor: naranja,
                                      ),
                                      Checkbox(
                                        value: this.estadoInicial == q,
                                        onChanged: (valor) {
                                          if (valor) {
                                            this.estadoInicial = q;
                                          }
                                          setState(() {});
                                        },
                                        activeColor: naranja,
                                        checkColor: Colors.white,
                                      )
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      titulo('Tabla de transiciones'),
                      SizedBox(
                        height: 15.0,
                      ),
                      contenedor(
                        0.80,
                        null,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: buildHeaderTabla(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200.0,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget builTablaContenedor() {
    return Row(
      children: <Widget>[
        Column(
          children: this.estados.map((q) => celda(q)).toList(),
        )
      ],
    );
  }

  Widget celda(String texto) {
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      width: 75.0,
      height: 50.0,
      child: Text(
        texto,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  List<Widget> buildHeaderTabla() {
    double h = 65.0;
    List<Widget> resultado = [];
    List<Widget> estadosColumna = [
      SizedBox(
        height: h,
      )
    ];

    for (var q in this.estados) {
      estadosColumna.add(celda(q));
    }
    resultado.add(
      Column(
        children: estadosColumna,
      ),
    );
    for (int j = 0; j < this.alfabeto.length; j++) {
      String letra = this.alfabeto[j];
      resultado.add(buildColumna(letra, j));
    }
    return resultado;
  }

  Column buildColumna(String letra, int letraIndex) {
    List<Widget> estadosInterseccion = [];
    estadosInterseccion.add(celda(letra));
    estadosInterseccion.add(SizedBox(
      height: 15.0,
    ));
    for (var i = 0; i < this.estados.length; i++) {
      String q = this.estados[i];
      estadosInterseccion.add(detector(i, letraIndex));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: estadosInterseccion,
    );
  }

  GestureDetector detector(int i, int j) {
    return GestureDetector(
      child: Container(
        height: 50.0,
        width: 70.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
        ),
      ),
      onTap: () {
        /* showDialog(
            context: context,
            builder: (BuildContext context) {
              //Here we will build the content of the dialog
              return AlertDialog(
                title: Text("Report Video"),
                content: MultiSelectChip(reportList),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Report"),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
            }); */
      },
    );
  }

  Text textoInfo(String texto) {
    return Text(
      texto,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  void generarEstados() {
    this.estados = [];
    for (var i = 0; i < this.cantidadEstados; i++) {
      this.estados.add("q$i");
    }
    setState(() {});
  }

  Widget contenedor(double dx, double dy, Widget child) {
    return Container(
      width: ancho * dx,
      height: dy == null ? null : alto * dy,
      child: Card(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: child,
        ),
      ),
    );
  }

  Widget titulo(String text) {
    return Text(
      text,
      style: TextStyle(
        color: naranja,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
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
                  textoInfo(
                      "Asigna la cantidad de estados, alfabeto y las transiciones."),
                ],
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
          ],
        ),
      ),
    );
  }
}
