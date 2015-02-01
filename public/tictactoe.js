function fetchBoard() {
  "use strict";
  var board;
  board = ['', '', '', '', '', '', '', '', ''];
  $("#squares td").each(function (index) {
    board[index + 1] = $(this).text();
  });
  return board;
}

function showGameOver(result) {
  "use strict";
  var target;
  target = $("#result");
  if (result > 0) {
    target.css('color', '#800');
    target.text("You win!");
  } else if (result < 0) {
    target.css('color', '#008');
    target.text("I win!");
  } else {
    target.css('color', '#505');
    target.text("Tie game.");
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
  var playerSquare, computerSquare, board, result, oLocation, oCell;

  playerSquare = $(this);

  // return if square is already full or if game is over !!!CHANGE GAME OVER CHECK!!!
  // if (playerSquare.text() !== '' || checkWin(fetchBoard()) !== 0) {
  //   return;
  // }

  // // place 'X' at selected location
  playerSquare.css('color', '#800');
  playerSquare.text('X');

  board = fetchBoard();

  // $.get("ajax", { squareId: playerSquare.attr("id") }).done(function ( computerMove ) {
  $.get("ajax", { boardArray: board }).done(function ( computerMove ) {
    computerSquare = $(computerMove.squareId);
    // console.log(computerMove.squareId);
    computerSquare.css('color', '#800');
    computerSquare.text('O');
  }, "json");

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