# Board
Problem


We consider the chess-solitaire game, a one-player game on a 4 × 4 board (see Figure 1a). Row indices start
with 1 and increase as we move downwards vertically. Similarly, column indices start with 1 and increase
as we move rightwards horizontally. A slot (r, c) on the board refers to the intersection of some valid row r
and column c (see Figure 1b). An occupied slot is placed with a chess piece; otherwise, it is unoccupied.

....

....

....

....

(a) A Board with No Occupied Slots
(1,1)(1,2)(1,3)(1,4)
(2,1)(2,2)(2,3)(2,4)
(3,1)(3,2)(3,3)(3,4)
(4,1)(4,2)(4,3)(4,4)

(b) Referencing Slots on the Board

Figure 1: Representing the 4 × 4 Board for a Chess-Solitaire Game

6.1 Rules of the Game
1. Before a game starts, the board is set up with chess pieces of various kinds: kings, queens, knights,
bishops, rooks, and pawns. Multiple chess pieces of the same kind may be placed on distinct slots.

2. Each kind of chess pieces has a set of possible moves (see below).

3. A possible move is valid if it can capture another chess without being blocked on the way of that move.
– A possible move is not necessarily a valid move (if it cannot capture a chess piece or it is blocked
by some other chess pieces on the way of the move).
– A valid move is always a possible move.

4. The player wins if they can keep making valid moves such that that one chess piece is left on the board.

5. The player loses if there are no valid moves but more than one chess pieces are left on the board.
