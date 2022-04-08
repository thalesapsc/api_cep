import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _recuperarCep() async {
    var url = Uri.parse('https://viacep.com.br/ws/04860160/json/');
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno['logradouro'];
    String complemento = retorno['complemento'];
    String bairro = retorno['bairro'];
    String localidade = retorno['localidade'];

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
            RaisedButton(
              child: Text('Clique aqui'),
              onPressed: _recuperarCep,
            )
          ],
        ),
      ),
    );
  }
}
