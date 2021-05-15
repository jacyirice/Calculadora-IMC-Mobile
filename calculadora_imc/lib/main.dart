import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Calculadora IMC",
              style: TextStyle(
                fontSize: 35,
              )
          ),
          FormPage(),
        ],
      ),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, Object> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: new InputDecoration(labelText: "Digite a sua altura aqui"),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) return "Campo obrigatorio!";
                if (num.tryParse(value) <= 0)
                  return "Digite um valor superior a 0.";
                return null;
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
              ],
              onSaved: (value) =>_formData['altura'] = value,
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: new InputDecoration(labelText: "Digite o seu peso aqui"),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) return "Campo obrigatorio!";
                if (num.tryParse(value) <= 0)
                  return "Digite um valor superior a 0.";
                return null;
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
              ],
              onSaved: (value) =>_formData['peso'] = value,
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              child: Text("Continuar"),
              onPressed: () {
                final isValid = _formKey.currentState.validate();
                if (isValid) {
                  _formKey.currentState.save();
                  // Navigator.of(context).push();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}