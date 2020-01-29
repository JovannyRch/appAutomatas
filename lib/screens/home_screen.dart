import 'package:automatas/screens/automata_input.dart';
import 'package:flutter/material.dart';
import 'er_input_screen.dart';
import 'package:automatas/components/fondo_component.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaActual = 0;
  Color naranja = Color.fromRGBO(241, 142, 17, 1.0);
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: paginaActual,
      children: <Widget>[
        Scaffold(
          body: Stack(
            children: <Widget>[
              FondoComponent(),
              _titulo(),
            ],
          ),
          bottomNavigationBar: _bottomNavigationBar(context),
        ),
        Scaffold(
          body: Stack(
            children: <Widget>[
              FondoComponent4(),
              SafeArea(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20.0),
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: naranja,
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Creado por",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.orange,
                              child: Container(
                                color: Colors.orange,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: _bottomNavigationBar(context),
        )
      ],
    );
  }

  Widget _titulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Autómatas",
              style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Genera tus autómatas desde una expresión regular o convierte entre autómatas.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(
              height: 150.0,
            ),
            _tabla()
          ],
        ),
      ),
    );
  }

  Widget _tabla() {
    return Table(
      children: [
        TableRow(children: [
          botonRedondo(
              Icons.border_color,
              Hero(
                tag: 'er',
                child: _txtTitle('Expresiones regulares'),
              ), () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ERInputPage()));
          }),
          botonRedondo(
              Icons.autorenew,
              Hero(
                tag: 'automatas',
                child: _txtTitle("Conversiones"),
              ), () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AutomataInput()));
          }),
        ]),
      ],
    );
  }

  Widget _txtTitle(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 18.0),
      textAlign: TextAlign.center,
    );
  }

  Widget botonRedondo(IconData icon, Hero h, Function callback) {
    return GestureDetector(
      child: Container(
        height: 200,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(62, 67, 107, 0.7),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              child: Icon(
                icon,
                size: 35.0,
                color: Colors.white,
              ),
              radius: 35.0,
              backgroundColor: Color.fromRGBO(241, 142, 17, 1.0),
            ),
            h
          ],
        ),
      ),
      onTap: callback,
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
          primaryColor: Colors.orangeAccent,
          textTheme: Theme.of(context).textTheme.copyWith(
                  caption: TextStyle(
                color: Color.fromRGBO(116, 117, 152, 1.0),
              ))),
      child: BottomNavigationBar(
        currentIndex: this.paginaActual,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                this.paginaActual = 0;
                setState(() {});
              },
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                  this.paginaActual = 1;
                  setState(() {});
                },
              ),
              title: Container()),
        ],
      ),
    );
  }
}
