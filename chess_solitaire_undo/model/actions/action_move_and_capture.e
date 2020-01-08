note
	description: "Summary description for {ACTION_MOVE_AND_CAPTURE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ACTION_MOVE_AND_CAPTURE

inherit
	ACTION

create
	make_move_and_capture

feature
	make_move_and_capture(r1: INTEGER; c1: INTEGER; r2: INTEGER; c2: INTEGER)
		do
			make
			row1 := r1
			col1 := c1
			row2 := r2
			col2 := c2
			create second.make
			second := model.b.board.item (r2, c2).deep_twin
			create first.make
			first := model.b.board.item (r1, c1).deep_twin
		end

feature --parameter
	col1,row1,row2,col2: INTEGER
	first: CHESS
	second: CHESS


feature{ETF_MODEL}
	execute
--		local
--			temp: CHESS
		do
			check attached {BOARD} model.b as board then
--				temp := board.board.item (row1, col1)
--				board.board.put(board.null, row1, col1)
--				board.board.put (temp, row2, col2)
--				board.noc.set_item(board.noc - 1)
--				if
--					board.noc = 1
--				then
--					board.over.set_item(true)
--				elseif
--					board.lose
--				then
--					board.over.set_item(true)
--				end
				board.move_and_capture (row1, col1, row2, col2)
			end
				if
						model.b.noc = 1
					then
						model.set_error ("Game Over: You Win!")
					elseif
						model.b.lose
					then
						model.set_error ("Game Over: You Lose!")
					else
						model.set_error ("Game In Progress...")
					end
		end

	redo
		do
			execute
		end

	undo
		do
			model.set_error ("Game In Progress...")
			check attached {board} model.b as board then
				board.un_move_and_capture(row1, col1, row2, col2, first, second)
			end
		end


end
