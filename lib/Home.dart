import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCep = TextEditingController();

  var _resultado = 'Resultado';

  _recuperarCep() async {
    var cepDigitado = _controllerCep.text;
    var url = Uri.parse('https://viacep.com.br/ws/${cepDigitado}/json/');
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno['logradouro'];
    String complemento = retorno['complemento'];
    String bairro = retorno['bairro'];
    String localidade = retorno['localidade'];

    setState(() {
      _resultado = '${logradouro}, ${complemento}, ${bairro}';
    });

    print(
        'resposta logradouro: ${logradouro} complemento: ${complemento} bairro: ${bairro} localidade: ${localidade}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consummo de serviço web'),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Digite o Cep: ex: 01524010'),
              style: TextStyle(fontSize: 20),
              controller: _controllerCep,
            ),
            RaisedButton(
              child: Text('Clique aqui'),
              onPressed: _recuperarCep,
            ),
            Text(_resultado)
          ],
        ),
      ),
    );
  }
}
