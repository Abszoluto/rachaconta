import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // VARIAVEIS
  final _tValorTotal = TextEditingController();
  final _tQuantidadePessoas = TextEditingController();
  final _tPessoasAlc = TextEditingController();
  final _tValorAlc = TextEditingController();
  var _infoText = "Informe seus dados!";
  var _infoText2 = "";
  var _formKey = GlobalKey<FormState>();
  bool _value1 = false;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("App racha conta"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh),
                onPressed: _resetFields)
          ],
        ),
        body: _body(),
      );
    }

    // PROCEDIMENTO PARA LIMPAR OS CAMPOS
    void _resetFields(){
      _tValorTotal.text = "";
      _tQuantidadePessoas.text = "";
      _tPessoasAlc.text = "";
      _tValorAlc.text = "";
      setState(() {
        _infoText = "Preencha os campos !";
        _infoText2 = "";
        _value1 = false;
        _formKey = GlobalKey<FormState>();
      });
    }

    _body() {
      return SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _editText("Valor total da conta", _tValorTotal,),
                _editText("Quantidade de pessoas", _tQuantidadePessoas,),
                _editText("Valor de bebidas alcoolicas", _tValorAlc,),
                _editText("Quantidade de pessoas que beberam bebidas alcoolicas", _tPessoasAlc,),
                /*
                new CheckboxListTile(
                  value: _value1,
                  onChanged: _value1Changed,
                  title: new Text('Converter para Kelvin'),
                  controlAffinity: ListTileControlAffinity.leading,
                  subtitle: new Text(''),
                  secondary: new Icon(Icons.archive),
                  activeColor: Colors.red,
                ),
                */
                _buttonCalcular(),
                _textInfo(),
                _textInfo2(),
              ],
            ),
          ));
    }
    // Widget text
    _editText(String field, TextEditingController controller) {
      return TextFormField(
        controller: controller,
        validator: (s) => _validate(s, field),
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 22,
          color: Colors.blue,
        ),
        decoration: InputDecoration(
          labelText: field,
          labelStyle: TextStyle(
            fontSize: 22,
            color: Colors.grey,
          ),
        ),
      );
    }

    // PROCEDIMENTO PARA VALIDAR OS CAMPOS
    String _validate(String text, String field) {
      if (text.isEmpty) {
        return "Digite $field";
      }
      return null;
    }

    // Widget button
    _buttonCalcular() {
      return Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 20),
        height: 45,
        child: RaisedButton(
          color: Colors.blue,
          child:
          Text(
            "Calcular",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          onPressed: () {
            if(_formKey.currentState.validate()){
              _calculate();
            }
          },
        ),
      );
    }

    // PROCEDIMENTO PARA CALCULAR O IMC
    void _calculate(){
      setState(() {
        double valorConta = double.parse(_tValorTotal.text);
        double quantidadePessoas = double.parse(_tQuantidadePessoas.text);
        double pessoasAlc = double.parse(_tPessoasAlc.text);
        double valorAlc = double.parse(_tValorAlc.text);
        double valorInd = 0;
        double pessoaAlc = 0;
        String respostaAlc = "";
        _infoText2 = "";
        valorInd = valorConta/quantidadePessoas;
        if (pessoasAlc > 0){
          valorInd = (valorConta - valorAlc)/quantidadePessoas;
          double pessoaAlc = (valorAlc/pessoasAlc) + valorInd;
          String respostaAlc = pessoaAlc.toStringAsPrecision(4);
          _infoText2 = "Valor a pagar por pessoa (com alcool): " + respostaAlc;
        }else {
          valorInd = valorConta/quantidadePessoas;
        }

        String resposta = valorInd.toStringAsPrecision(4);
        _infoText = "Valor a pagar por pessoa (sem alcool): " + resposta;
       /*
        _infoText = "";
        _infoText2 = "";
        _infoText3 = "";
        _infoText4 = "";
        double temperatura = double.parse(_tTemperatura.text);
        double kelvin = temperatura + 273;
        double fahren = (temperatura * 1.8) + 32;
        double reaumur = temperatura * 0.8;
        double rankine = (temperatura + 273.15) * (9/5);
        String kelvinStr = kelvin.toStringAsPrecision(4);
        String fahrenStr = fahren.toStringAsPrecision(4);
        String reaumurStr = reaumur.toStringAsPrecision(4);
        String rankineStr = rankine.toStringAsPrecision(4);
        if (_value1)
        _infoText = "Temperatura em Kelvin: " + kelvinStr;
        if (_value2)
        _infoText2 = "Temperatura em Fahrenheit: " + fahrenStr;
        if (_value3)
        _infoText3 = "Temperatura em Reaumur: " + reaumurStr;
        if (_value4)
        _infoText4 = "Temperatura em Rankine: " + rankineStr;
        */
      });
    }

    // // Widget text
    _textInfo() {
        return Text(
          _infoText,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue, fontSize: 25.0),
        );
    }
    _textInfo2() {
      return Text(
        _infoText2,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.blue, fontSize: 25.0),
      );
    }
}
