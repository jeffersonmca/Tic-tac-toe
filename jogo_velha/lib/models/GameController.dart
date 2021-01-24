import 'package:jogovelha/util/PlayerType.dart';
import 'package:jogovelha/util/WinnerType.dart';
import 'package:jogovelha/models/BoardCell.dart';
import 'package:jogovelha/util/Constants.dart';
import 'package:jogovelha/util/WinnerRules.dart';

class GameController {

  // Células do tabuleiro
  List<BoardCell> cells = [];
  // Movimentos do player 1
  List<int> movesPlayer1 = [];
  // Movimentos do player 2
  List<int> movesPlayer2 = [];
  // Jogador que esta jogando no momento
  PlayerType currentPlayer;
  // Usado para mostrar a vez do jogador
  String labelCurrentPlayer;

  // Construtor da classe
  GameController() {
    _initialize();
  }

  // Inicializa o tabuleiro vazio
  void _initialize() {
    movesPlayer1.clear();
    movesPlayer2.clear();
    currentPlayer = PlayerType.player1;
    labelCurrentPlayer = "Jogador ${PLAYER1_SYMBOL}";
    cells = List<BoardCell>.generate(BOARD_SIZE, (index) => BoardCell(index + 1));
  }

  // Tem jogadas para serem feitas?
  bool hasMoves() {
    return (movesPlayer1.length + movesPlayer2.length) != BOARD_SIZE;
  }

  // Reinicia o game
  void reset() {
    _initialize();
  }

  void markBoardCellByIndex(index) {

    final tile = cells[index];

    if (currentPlayer == PlayerType.player1) {
      _markBoardCellWithPlayer1(tile);
    } else {
      _markBoardCellWithPlayer2(tile);
    }

    tile.enable = false;
  }

  // Muda a determinada célula para o conteúdo ser do player 1
  void _markBoardCellWithPlayer1(BoardCell cell) {
    cell.symbol = PLAYER1_SYMBOL;
    cell.color = PLAYER1_COLOR;
    movesPlayer1.add(cell.id);
    // Muda a vez
    currentPlayer = PlayerType.player2;
    labelCurrentPlayer = "Jogador ${PLAYER2_SYMBOL}";
  }

  // Muda a determinada célula para o conteúdo ser do player 2
  void _markBoardCellWithPlayer2(BoardCell cell) {
    cell.symbol = PLAYER2_SYMBOL;
    cell.color = PLAYER2_COLOR;
    movesPlayer2.add(cell.id);
    // Muda a vez
    currentPlayer = PlayerType.player1;
    labelCurrentPlayer = "Jogador ${PLAYER1_SYMBOL}";
  }

  // Verifica se o jogador ganhou o jogo
  bool _checkPlayerWinner(List<int> moves) {

    // Verifica as 3 jogadas se elas batem com as regras de vencer o jogo
    return winnerRules.any((rule) =>
        moves.contains(rule[0]) &&
        moves.contains(rule[1]) &&
        moves.contains(rule[2]));
  }

  // Verifica se alguem venceu ou deu velha de acordo com o movimento dos jogadores
  WinnerType checkWinner() {
    // Jogador 1
    if (_checkPlayerWinner(movesPlayer1)) return WinnerType.player1;
    // Jogador 2
    if (_checkPlayerWinner(movesPlayer2)) return WinnerType.player2;
    // Deu velha
    return WinnerType.none;
  }
}