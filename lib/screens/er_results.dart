import 'package:automatas/calculadora/conversionAutomatas.dart';
import 'package:automatas/calculadora/rexpresion.dart';
import 'package:automatas/components/fondo_component.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class ResultsER extends StatefulWidget {
  String infija = "";
  Expresion expresion;
  Automata automataActual;

  List<String> operadores = ["*", ".", "+", "(", ")"];

  Map prec = {"*": 2, ".": 1, "+": 0, "(": -1, ")": -2};
  ResultsER({this.infija}) {
    expresion =
        Expresion(infija: infija, operadores: operadores, precedencia: prec);
    automataActual = expresion.dfaMinSinVacio;
  }

  @override
  _ResultsERState createState() => _ResultsERState();
}

class _ResultsERState extends State<ResultsER> {
  TabController controllerTab;

  double alto;

  double ancho;

  Color naranja = Color.fromRGBO(241, 142, 17, 1.0);

  Color naranjaOscuro = Color.fromRGBO(236, 98, 18, 1.0);

  Color fondo = Color.fromRGBO(52, 54, 101, 1.0);

  String tituloPrincipal = "Autómata finito reducido";
  int tipoAutomata = 1;

  SolidController controller = new SolidController();
  TextEditingController controllerCadena = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    alto = MediaQuery.of(context).size.height;
    ancho = MediaQuery.of(context).size.width;
    return Scaffold(
        /* bottomSheet: SolidBottomSheet(
          showOnAppear: true,
          controller: controller,
          headerBar: Container(
            color: naranja,
            height: alto * 0.05,
            child: Center(
              child: Text(
                "Desliza para más opciones",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(13.0),
            width: double.infinity,
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
            height: alto * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Tipo de Autómata",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                opcionAutomata('Automata Finito Determinista Minimizado', 1,
                    this.widget.expresion.dfaMinSinVacio),
                opcionAutomata('Automata Finito Determinista ', 2,
                    this.widget.expresion.dfa),
                opcionAutomata('Automata Finito No Determinista', 3,
                    this.widget.expresion.nfa),
                opcionAutomata(
                    'Automata de Thompson ', 4, this.widget.expresion.thompson),
              ],
            ),
          ),
        ), */
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Alert(
                context: context,
                title: "Evaluar Cadena",
                content: Column(
                  children: <Widget>[
                    TextField(
                      autofocus: true,
                      controller: controllerCadena,
                      decoration: InputDecoration(
                        icon: Icon(Icons.spellcheck),
                        labelText: 'Escriba la cadena',
                      ),
                      onSubmitted: (value) {
                        Navigator.pop(context);
                        this.validarCadena();
                      },
                    ),
                    FlatButton(
                      color: Colors.grey.withOpacity(0.2),
                      child: Text("Limpiar"),
                      onPressed: () {
                        this.controllerCadena.clear();
                      },
                    )
                  ],
                ),
                buttons: [
                  DialogButton(
                    color: naranja,
                    onPressed: () {
                      Navigator.pop(context);
                      this.validarCadena();
                    },
                    child: Text(
                      "Validar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          },
          label: Text('Evaluar Cadena'),
          icon: Icon(Icons.spellcheck),
          backgroundColor: naranja,
        ),
        body: Stack(
          children: <Widget>[
            FondoComponent2(),
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            tituloPrincipal,
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10.0,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 45.0,
                      ),
                      titulo('Expresión regular'),
                      contendor(
                          0.75,
                          0.06,
                          textoInfo(
                            '${this.widget.infija}',
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      titulo('Alfabeto'),
                      contendor(
                          0.75,
                          0.06,
                          textoInfo(
                            '${widget.automataActual.alphabet}',
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      titulo('Estados finales'),
                      contendor(
                          0.75,
                          0.06,
                          textoInfo(
                            '${widget.automataActual.finalStates.length == 1 ? widget.automataActual.finalStates[0] : widget.automataActual.finalStates}',
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              titulo('Estado inicial'),
                              contendor(
                                0.3,
                                0.06,
                                textoInfo(
                                    '${widget.automataActual.initialState}'),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              titulo('# de estados'),
                              contendor(
                                0.3,
                                0.06,
                                textoInfo(
                                    '${widget.automataActual.states.length}'),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      titulo('Tabla de transiciones'),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Card(
                          color: Colors.transparent,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: _crearTabla(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 130.0,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  void validarCadena() {
    bool isValido =
        this.widget.expresion.validarCadena(this.controllerCadena.text);

    if (isValido) {
      Alert(
          context: context,
          type: AlertType.success,
          title: "VALIDO",
          desc:
              "La cadena '${this.controllerCadena.text}' pertenece al lenguaje",
          buttons: [
            DialogButton(
              color: naranja,
              onPressed: () => Navigator.pop(context),
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]).show();
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "INVALIDO",
        desc:
            "La cadena '${this.controllerCadena.text}' no pertenece al lenguaje",
        buttons: [
          DialogButton(
            color: naranja,
            onPressed: () => Navigator.pop(context),
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
    }
  }

  Row opcionAutomata(String texto, int valor, Automata a) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          texto,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Checkbox(
          activeColor: naranja,
          value: this.tipoAutomata == valor,
          onChanged: (value) {
            if (value) {
              this.tipoAutomata = valor;
              this.widget.automataActual = a;
              this.widget.automataActual.printAutomata();
            }
            setState(() {});
          },
        )
      ],
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

  Widget contendor(double dx, double dy, Widget child) {
    return Container(
      width: ancho * dx,
      height: alto * dy,
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
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _crearTabla() {
    List<DataColumn> primeraFila = [
      DataColumn(
        label: Text(
          "Qs",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.0,
          ),
        ),
      )
    ];

    for (String letra in widget.automataActual.alphabet) {
      primeraFila.add(DataColumn(
        label: Text(
          letra,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.0,
          ),
          textAlign: TextAlign.center,
        ),
      ));
    }

    List<DataRow> filas = [];
    for (String q in widget.automataActual.states) {
      bool isInicial = widget.automataActual.initialState == q;
      bool isFinal = widget.automataActual.finalStates.contains(q);
      String qEstilizado = q;
      if (isFinal) {
        qEstilizado = "*$qEstilizado";
      }
      if (isInicial) {
        qEstilizado = "-> $qEstilizado";
      }
      List<DataCell> data = [];
      data.add(DataCell(Text(
        qEstilizado,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
        textAlign: TextAlign.center,
      )));
      for (String letra in widget.automataActual.alphabet) {
        Transicion t = widget.automataActual.getTrasiciones(q, letra);
        if (t != null) {
          data.add(
            DataCell(Text(
              t.qouput.length == 1
                  ? t.qouput[0]
                  : t.qinput
                      .toString()
                      .replaceAll('[', '{')
                      .replaceAll('[', '}'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            )),
          );
        } else {
          data.add(DataCell(Text("")));
        }
      }
      filas.add(DataRow(cells: data));
    }

    print(primeraFila.length);
    return DataTable(
      columns: primeraFila,
      rows: filas,
    );
  }
}
