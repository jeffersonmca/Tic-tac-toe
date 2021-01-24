// Regras que ganham o jogo
const winnerRules = [
  [1, 2, 3], // Linha
  [4, 5, 6], // Linha
  [7, 8, 9], // Linha
  [1, 4, 7], // Coluna
  [2, 5, 8], // Coluna
  [3, 6, 9], // Coluna
  [1, 5, 9], // Diagonal principal
  [3, 5, 7], // Diagonal secundária
];