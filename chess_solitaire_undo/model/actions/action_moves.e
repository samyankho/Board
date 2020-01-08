rnote
	description: "Summary description for {ACTION_MOVES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ACTION_MOVES

inherit
	ACTION

create
	make_move

feature
	make_move(r1: INTEGER; c1: INTEGER)
		do
			make
			row := r1
			col := c1
		end

feature -- attribute
	row, col : INTEGER



feature{ETF_MODEL}
	execute
		do
			check attached {board} model.b as board then
				board.moves(row, col)
			end
			model.set_error ("Game In Progress...")
		end

	redo
		do
			execute
		end

	undo
		do
--			model.un_moves
		end

end
