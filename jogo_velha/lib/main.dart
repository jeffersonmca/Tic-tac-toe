import 'package:flutter/material.dart';
import 'package:jogovelha/util/Constants.dart';
import 'package:jogovelha/views/home.dart';

/**
 * REFERÊNCIAS PARA TER IDEIAS PARA A CRIAÇÃO DESTE PROJETO.
 * https://github.com/kleberandrade/tic-tac-toe-flutter
 * https://medium.com/flutter-comunidade-br/criando-um-jogo-da-velha-em-flutter-50347537c926
 */

/**
 * Primeiro método a ser executado pela aplicação
 */
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título da aplicação
      title: GAME_TITLE,
      // Entra no sistema
      home: Home(),
    );
  }
}