import 'package:calculadora_imc/imc_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'imc_data.dart';
import 'package:url_launcher/url_launcher.dart';

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Calculadora IMC",
              style: TextStyle(
                fontSize: 35,
              )),
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
  final ImcResults _imcResults = ImcResults();
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
              decoration:
                  new InputDecoration(labelText: "Digite a sua altura aqui"),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) return "Campo obrigatorio!";
                if (double.tryParse(value) <= 0.0)
                  return "Digite um valor superior a 0.";
                return null;
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              onSaved: (value) => _formData['altura'] = double.tryParse(value),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration:
                  new InputDecoration(labelText: "Digite o seu peso aqui"),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) return "Campo obrigatorio!";
                if (double.tryParse(value) <= 0.0)
                  return "Digite um valor superior a 0.";
                return null;
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              onSaved: (value) => _formData['peso'] = double.tryParse(value),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              child: Text("Continuar"),
              onPressed: () {
                final isValid = _formKey.currentState.validate();
                if (isValid) {
                  _formKey.currentState.save();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ResultImcPage(
                        result: _imcResults.getMyImcResult(
                            _formData['peso'], _formData['altura']),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ResultImcPage extends StatelessWidget {
  final ImcResult result;
  const ResultImcPage({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        automaticallyImplyLeading: false,
        title: Text("Resultado"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Seu IMC: '+ result.imc.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Image(
                        image: AssetImage(result.img),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      result.interval,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      result.title,
                      textAlign: TextAlign.justify,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      result.description,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: Text('Ver mais'),
                      onPressed: _launchURL,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_launchURL() async {
  const url =
      'https://abeso.org.br/obesidade-e-sindrome-metabolica/calculadora-imc/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Não foi possivel acessar $url';
  }
}
