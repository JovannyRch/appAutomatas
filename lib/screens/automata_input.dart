import 'package:automatas/calculadora/conversionAutomatas.dart';
import 'package:automatas/screens/automata_results.dart';
import 'package:flutter/material.dart';
import 'package:automatas/components/fondo_component.dart';
import 'package:flutter/rendering.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
  List<Transicion> transiciones = [];
  List<List<Transicion>> ts = [[]];
  Color naranjaOscuro = Color.fromRGBO(236, 98, 18, 1.0);

  Color fondo = Color.fromRGBO(52, 54, 101, 1.0);
  bool isThompson = false;

  int tipoAutomata = 1;
  @override
  Widget build(BuildContext context) {
    alto = MediaQuery.of(context).size.height;
    ancho = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Convertir'),
          icon: Icon(Icons.autorenew),
          backgroundColor: naranja,
          onPressed: () {
            //Validación
            String msg = "";
            if (this.alfabeto.length == 0) {
              msg = "No tiene alfabeto";
            } else if (this.estados.length == 0) {
              msg = "No tiene estados";
            } else if (this.estadosFinales.length == 0) {
              msg = "Debe tener al menos un estado final";
            }
            if (msg.length > 0) {
              Alert(
                  type: AlertType.warning,
                  context: context,
                  title: "Autómata Inválido",
                  desc: msg,
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: naranja,
                    ),
                  ]).show();
              return;
            }

            List<Transicion> ts = [];
            bool bandera = false;
            for (var i = 0; i < this.estados.length; i++) {
              for (var j = 0; j < this.alfabeto.length; j++) {
                Transicion t = this.ts[i][j];
                if (t.qouput.length > 0) {
                  bandera = true;
                  ts.add(t);
                }
              }
            }
            if (!bandera) {
              Alert(
                  type: AlertType.warning,
                  context: context,
                  title: "Autómata Inválido",
                  desc: "Agrega transiciones",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: naranja,
                    ),
                  ]).show();
              return;
            }

            Automata a = new Automata(
              alphabet: this.alfabeto,
              states: this.estados,
              finalStates: this.estadosFinales,
              initialState: this.estadoInicial,
              transitions: ts,
            );
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AutomataResults(
                          automataEntrada: a,
                          isThompson: this.isThompson,
                        )));
          },
        ),
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
                          0.11,
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                this.alfabeto.length == 0
                                    ? 'Presione aquí'
                                    : this
                                        .alfabeto
                                        .toString()
                                        .replaceAll('[', '')
                                        .replaceAll(']', ''),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () {
                              TextEditingController textEditingController =
                                  new TextEditingController();
                              Alert(
                                  context: context,
                                  title: "Alfabeto",
                                  desc: 'Separe el alfabeto con minusculas',
                                  content: Column(
                                    children: <Widget>[
                                      TextField(
                                        controller: textEditingController,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.spellcheck),
                                            labelText: 'Escriba aquí',
                                            helperText: 'Ejemplo: a,b,c,d'),
                                        onSubmitted: (value) {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                        color: Colors.grey.withOpacity(0.2),
                                        child: Text("Limpiar"),
                                        onPressed: () {
                                          textEditingController.clear();
                                        },
                                      )
                                    ],
                                  ),
                                  buttons: [
                                    DialogButton(
                                      color: naranja,
                                      onPressed: () {
                                        Navigator.pop(context);
                                        this.alfabeto = textEditingController
                                            .text
                                            .split(',');
                                        setState(() {});
                                        print(this.alfabeto);
                                      },
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ]).show();
                            },
                          )
                          /* TextField(
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
                            this.alfabeto = valor.split(',').toSet().toList();
                            this.crearTs();
                          },
                          onSubmitted: (valor) {
                            this.alfabeto = valor.split(',').toSet().toList();
                            this.crearTs();
                          },
                        ), */
                          ),
                      SizedBox(
                        height: 10.0,
                      ),
                      titulo('¿Tiene transiciones vacias?'),
                      contenedor(
                          0.23,
                          0.08,
                          Switch(
                            value: this.isThompson,
                            activeColor: naranja,
                            onChanged: (v) {
                              this.isThompson = v;
                              print(v);
                              if (v) {
                                this.alfabeto.add('');
                              } else {
                                this.alfabeto.remove('');
                              }
                              this.alfabeto.sort();
                              this.crearTs();
                            },
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      titulo('# de estados'),
                      contenedor(
                        0.75,
                        0.11,
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              this.estados.length == 0
                                  ? 'Presione aquí'
                                  : this.estados.length.toString(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            TextEditingController textEditingController =
                                new TextEditingController();
                            Alert(
                                context: context,
                                title: "Cantidad de estados",
                                content: Column(
                                  children: <Widget>[
                                    TextField(
                                      controller: textEditingController,
                                      keyboardType: TextInputType.number,
                                      autofocus: true,
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.spellcheck),
                                          labelText: 'Escriba aquí',
                                          helperText: 'Ejemplo: 3'),
                                      onSubmitted: (value) {
                                        Navigator.pop(context);
                                        print("hola");
                                      },
                                    ),
                                    FlatButton(
                                      color: Colors.grey.withOpacity(0.2),
                                      child: Text("Limpiar"),
                                      onPressed: () {
                                        textEditingController.clear();
                                      },
                                    )
                                  ],
                                ),
                                buttons: [
                                  DialogButton(
                                    color: naranja,
                                    onPressed: () {
                                      Navigator.pop(context);
                                      this.cantidadEstados =
                                          int.parse(textEditingController.text);
                                      this.generarEstados();
                                      this.crearTs();
                                    },
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  )
                                ]).show();
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

  void crearTs() {
    if (this.isThompson && !this.alfabeto.contains('')) this.alfabeto.add('');
    this.alfabeto.sort();
    this.ts = this
        .estados
        .map((q) => this
            .alfabeto
            .map((a) => new Transicion(qinput: '', leter: '', qouput: []))
            .toList())
        .toList();
    setState(() {});
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
      width: 80.0,
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
        width: 80.0,
        child: SingleChildScrollView(
          child: Text(
            this
                .ts[i][j]
                .qouput
                .toString()
                .replaceFirst('[', '')
                .replaceFirst(']', ''),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
        ),
      ),
      onTap: () {
        print(ts);
        OpcionesEstados opcionesEstados = new OpcionesEstados(
            estados: this.estados, qOutput: this.ts[i][j].qouput);
        Alert(
            context: context,
            title: "Transición ${this.estados[i]},${this.alfabeto[j]}",
            content: opcionesEstados,
            buttons: [
              DialogButton(
                color: naranja,
                onPressed: () {
                  Navigator.pop(context);
                  Transicion t = new Transicion(
                      qinput: this.estados[i],
                      leter: this.alfabeto[j],
                      qouput: opcionesEstados.qOutput);

                  this.ts[i][j] = t;
                  setState(() {});
                },
                child: Text(
                  "Crear",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ]).show();
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
                    fontSize: ancho * 0.1,
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

class OpcionesEstados extends StatefulWidget {
  List<String> estados = [];
  List<String> qOutput = [];

  OpcionesEstados({this.estados, this.qOutput});

  @override
  _OpcionesEstadosState createState() => _OpcionesEstadosState();
}

class _OpcionesEstadosState extends State<OpcionesEstados> {
  Color naranja = Color.fromRGBO(241, 142, 17, 1.0);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: this
            .widget
            .estados
            .map((q) => SwitchListTile(
                  title: Text(q),
                  activeColor: naranja,
                  value: this.widget.qOutput.contains(q),
                  onChanged: (value) {
                    if (value) {
                      this.widget.qOutput.add(q);
                    } else
                      this.widget.qOutput..remove(q);
                    setState(() {});
                  },
                ))
            .toList(),
      ),
    );
  }
}
