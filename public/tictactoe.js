"use strict";

function fetchBoard() {
  var board;
  board = ['', '', '', '', '', '', '', '', ''];
  $("#squares td").each(function (index) {
    board[index] = $(this).text();
  });
  return board;
}

function showGameOver() {
  var target;
  target = $("#result");
  target.css('color', '#000');
  target.text("DOMINATION");
}

function getGameStatus() {
  return $("#result").text();
}

function noEmptySquares(value) {
  if (value !== '') {
    return true
  } else {
    return false
  }
}

function resetGame() {
  var target;
  $("#squares td").text('');
  target = $("#result");
  target.css('color', '#000');
  target.text('Go ahead. You might win this time...');
}

function moveAt() {
  var playerSquare, computerSquare, board;
  playerSquare = $(this);

  if (playerSquare.text() !== '' || getGameStatus() === 'DOMINATION') {
    return;
  }
  playerSquare.css('color', '#800');
  playerSquare.text('X');

  board = fetchBoard();

  if (board.every(noEmptySquares)) {
    showGameOver();
  } else {
    $.get("ajax", { boardArray: board }).done(function ( serverResponse ) {
      computerSquare = $(serverResponse.squareId);
      computerSquare.css('color', '#800');
      computerSquare.text('O');
      if (serverResponse.gameOver === true) {
        showGameOver();
      };
    }, "json");
  };
}

$(document).ready(function () {
  $("#squares td").click(moveAt);
  $("#tictacreset").click(resetGame);
  resetGame();
});