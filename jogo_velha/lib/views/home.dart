import 'package:flutter/material.dart';
import 'package:jogovelha/util/WinnerType.dart';
import 'package:jogovelha/util/Constants.dart';
import 'package:jogovelha/models/GameController.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Controlador do modelo do jogo
  final _controller = GameController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body:_buildBody(),
    );
  }

  // Corpo do app
  _buildBody() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Labels auxiliares
          _buildLabels(),
          // Tabuleiro
          _buildBoard(),
          // Botão de resetar o jogo
          _buildResetButton(),
        ],
      ),
    );
  }

  // Labels auxiliares
  _buildLabels() {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(50),),
          Center(
            child: Text("Jogador ${PLAYER1_SYMBOL} vs Jogador ${PLAYER2_SYMBOL}",
              style: TextStyle(color: Colors.black, fontSize: 18),),
          ),
          Padding(padding: EdgeInsets.all(20),),
          Center(child: Text("Vez de: ${_controller.labelCurrentPlayer}",
            style: TextStyle(color: Colors.black, fontSize: 18),),
          ),
          Padding(padding: EdgeInsets.all(30),),
        ],
      ),
    );
  }

  // Tabuleiro
  _buildBoard() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: BOARD_SIZE,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: _buildCell,
      ),
    );
  }

  // Botão de resetar o jogo
  _buildResetButton() {
    return RaisedButton(
      padding: const EdgeInsets.all(20),
      child: Text("Resetar"),
      onPressed: (() {
        setState(() {
          _controller.reset();
        });
      }),
    );
  }

  // Criando as células
  Widget _buildCell(context, index) {
    return GestureDetector(
      onTap: () => _onMarkCell(index),
      child: Container(
        color: _controller.cells[index].color,
        child: Center(
          child: Text(
            _controller.cells[index].symbol,
            style: TextStyle(
              fontSize: 72.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Reseta o jogo
  _onResetGame() {
    setState(() {
      Navigator.pop(context);
      _controller.reset();
    });
  }

  // Quando o usuário clica em alguma célula
  _onMarkCell(index) {

    // Ela está liberada para ser clicada?
    if (!_controller.cells[index].enable) return;

    // Se estiver então modifica ela de acordo com o jogador
    setState(() {
      _controller.markBoardCellByIndex(index);
    });

    // Por fim, verifica vitória ou velha
    _checkWinner();
  }

  // Verifica vitória ou velha
  _checkWinner() {

    var winner = _controller.checkWinner();

    // Deu velha ou ainda não terminou o game?
    if (winner == WinnerType.none) {
      // Acabou as jogadas
      if (!_controller.hasMoves()) {
        _showTiedDialog();
      }
    // Algum jogador ganhou
    } else {
      // Pega o símbolo do vencedor
      String symbol = winner == WinnerType.player1 ? PLAYER1_SYMBOL : PLAYER2_SYMBOL;
      _showWinnerDialog(symbol);
    }
  }

  // Dialog da vitória de algum jogador
  _showWinnerDialog(String symbol) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(WIN_TITLE.replaceAll('[SYMBOL]', symbol)),
          content: Text(RESET_GAME),
          actions: [
            FlatButton(
              child: Text("Resetar"),
              onPressed: _onResetGame,
            ),
          ],
        );
      },
    );
  }

  // Dialog da velha
  _showTiedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(TIED_TITLE),
          content: Text(RESET_GAME),
          actions: [
            FlatButton(
              child: Text("Resetar"),
              onPressed: _onResetGame,
            ),
          ],
        );
      },
    );
  }
}