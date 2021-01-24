import 'package:flutter/material.dart';

/**
 * Célula do tabuleiro
 */
class BoardCell {

  // Não pode ser alterado o id dps de criado um objeto
  final int id;
  // Bolinha ou Xis
  String symbol;
  // Cor da célula
  Color color;
  // O usuário pode clicar na célula?
  bool enable;

  BoardCell(this.id, {
    this.symbol = '',
    this.color = Colors.black,
    this.enable = true,
  });
}