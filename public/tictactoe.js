function fetchBoard() {
  "use strict";
  var board;
  board = ['', '', '', '', '', '', '', '', ''];
  $("#squares td").each(function (index) {
    board[index] = $(this).text();
  });
  return board;
}

function showGameOver() {
  "use strict";
  var target;
  target = $("#result");
  target.css('color', '#505');
  target.text("Don't have a cow, man!");
}

function noEmptySquares(value, index, arr) {
  "use strict";
  if (value !== '') {
    return true
  } else {
    return false
  }
}

function resetGame() {
  "use strict";
  var target;

  $("#squares td").text('');
  target = $("#result");
  target.css('color', '#000');
  target.text('Click a square');
}

function moveAt() {
  "use strict";
  var playerSquare, computerSquare, board;

  playerSquare = $(this);

  if (playerSquare.text() !== '') {
    return;
  }

  // // place 'X' at selected location
  playerSquare.css('color', '#800');
  playerSquare.text('X');

  board = fetchBoard();

  if (board.every(noEmptySquares)) {
    showGameOver();
  } else {

  // $.get("ajax", { squareId: playerSquare.attr("id") }).done(function ( computerMove ) {
    $.get("ajax", { boardArray: board }).done(function ( serverResponse ) {
      computerSquare = $(serverResponse.squareId);
      // console.log(serverResponse.squareId);
      computerSquare.css('color', '#800');
      computerSquare.text('O');
    }, "json");
  };
  // // if game is over, display message
  // board = fetchBoard();
  // result = checkWin(board);
  // if (result !== 0) {
  //   showGameOver(result);
  //   return;
  // }

  // // find where to place the 'O'
  // oLocation = selectMove(board);
  // if (oLocation < 0) {
  //   // if there is no valid place, it is tie game
  //   showGameOver(0);
  //   return;
  // }

  // // place 'O' at location
  // board[oLocation] = 'O';
  // oCell = $("#cell" + oLocation);
  // oCell.css('color', '#008');
  // oCell.text('O');

  // // if game is over, display that
  // result = checkWin(board);
  // if (result !== 0) {
  //   showGameOver(result);
  //   return;
  // }
}

$(document).ready(function () {
  "use strict";

  $("#squares td").click(moveAt);
  $("#tictacreset").click(resetGame);
  resetGame();
});