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
                        height: MediaQuery.of(context).size.height * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: naranja.withOpacity(0.9),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Creado por",
                              style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.orange,
                              backgroundImage: AssetImage('images/jovas.jpg'),
                              radius: 50.0,
                            ),
                            Text(
                              'Jovanny Rch',
                              style: TextStyle(
                                fontFamily: 'Pacifico',
                                fontSize: 40.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'FLUTTER DEVELOPER',
                              style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                color: Colors.blueGrey.shade100,
                                fontSize: 20.0,
                                letterSpacing: 2.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                              width: 150.0,
                              child: Divider(
                                color: Colors.teal.shade100,
                              ),
                            ),
                            Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.phone,
                                    color: naranja,
                                  ),
                                  title: Text(
                                    '+527226227577',
                                    style: TextStyle(
                                      color: naranja,
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 17.0,
                                    ),
                                  ),
                                )),
                            Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.email,
                                    color: naranja,
                                  ),
                                  title: Text(
                                    'jovannyrch@gmail.com',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: naranja,
                                        fontFamily: 'Source Sans Pro'),
                                  ),
                                ))
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
              height: MediaQuery.of(context).size.height * 0.2,
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
