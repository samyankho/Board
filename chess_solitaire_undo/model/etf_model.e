note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create s.make_empty
			s := "Game being Setup..."
			create b.make
			showv := false
			i := 0
		end

feature -- model attributes
	s : STRING
	b : BOARD
	i : INTEGER
	showv: BOOLEAN

feature -- model operations
--	default_update
--			-- Perform update to the model state.
--		do
--			i := i + 1
--		end

	set_error(msg: STRING)
		do
			s := msg
		end

	reset
			-- Reset model state.
		do
			make
		end


	reset_game
		local
			action: ACTION_RESET_GAME
			do
				create action.make_reset_game
				action.execute
--				check attached {BOARD} b as board then
--					board.history.extend_history (action)
--				end

		end


	setup_chess(c: CHESS; row: INTEGER; col: INTEGER)
			 --Set up by adding a chess at (‘row‘, ‘col‘).
		local
			action: ACTION_SETUP_CHESS
			do
				create action.make_setup_game(c, row, col)
				action.execute
				check attached {BOARD} b as board then
					board.history.extend_history (action)
				end
			end

	start_game
			-- Start the game after setting up chess pieces.
		--require
		--	already_start: not started
		local
			action: ACTION_START_GAME
			do
				create action.make_start_game
				action.execute
				check attached {BOARD} b as board then
					board.history.extend_history (action)
				end
--				if
--						b.noc = 1
--				then
--						s := "Game Over: You Win!"
--				elseif
--						b.noc = 0
--				then
--						s := "Gamd Over: You Lose!"
--				else
--						s := "Game In Progress..."
--			end
		end

	move_and_capture(r1: INTEGER; c1: INTEGER; r2: INTEGER; c2: INTEGER)
		local
			action: ACTION_MOVE_AND_CAPTURE
			do
				create action.make_move_and_capture (r1, c1, r2, c2)
				action.execute
				check attached {BOARD} b as board then
					board.history.extend_history (action)
				end
--			if
--						b.noc = 1
--					then
--						s := "Game Over: You Win!"
--					elseif
--						b.lose
--					then
--						s := "Game Over: You Lose!"
--					else
--						s := "Game In Progress..."
--					end
		end


	moves(row: INTEGER; col: INTEGER)
		local
			action: ACTION_MOVES
			do
				create action.make_move (row, col)
				action.execute
--				check attached {BOARD} b as board then
--					board.history.extend_history (action)
--				end
				showv := true
		end


--	startaction:BOOLEAN
--		local
--			start: ACTION_COUNTER
--		do
--			create start.make_counter
--			result := b.history.item ~ start
--		end


	undo
		do
			check attached {BOARD} b as board then
				board.history.item.undo
			--	if board.history.index>1 then
					board.history.back
			--	end
			--	s := board.history.index.out
			end
		end

	redo
		do
			check attached {BOARD} b as board then
				board.history.forth
				board.history.item.redo
			end
		end



feature -- queries
	out : STRING

		local
		do
			create Result.make_empty
			Result.append ("  # of chess pieces on board: " + b.noc.out)
			Result.append ("%N  ")
			Result.append (s)
--			across nof as c loop
----				if c.item /~null then
--					Result.append (c.item.out)
----				end
--			end
--			Result.append ("%N")

			if (not showv) then

			across 1 |..| 4  is k loop
				Result.append ("%N  ")
				across 1 |..| 4 as j loop
					Result.append (b.board[k.item,j.item].out)
				end
				--result.append ("board1")
--				result.append (b.history.index.out)
--				result.append (b.history.count.out)
			end
			else
			across 1 |..| 4  is k loop
				Result.append ("%N  ")
				across 1 |..| 4 as j loop
					Result.append (b.board2[k.item,j.item].out)
				end
			end
					b.board2.make_filled (b.null, b.rows, b.cols)
					showv := false
					--result.append ("board2")
		end


		end

end




