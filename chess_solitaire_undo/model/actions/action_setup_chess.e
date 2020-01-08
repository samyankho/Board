note
	description: "Summary description for {ACTION_SETUP_CHESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ACTION_SETUP_CHESS

inherit
	ACTION

create
	make_setup_game

feature
	make_setup_game(c: CHESS; row: INTEGER; col: INTEGER)
		do
			make
			r1 := row
			c1 := col
			ch := c
		end

feature
	r1, c1: INTEGER
	ch: CHESS


feature{ETF_MODEL}
	execute
		do
			model.set_error ("Game being Setup...")
			check attached {board} model.b as board then
					model.b.setup_chess(ch, r1, c1)
			end
		end

	redo
		do
			execute
		end

	undo
		do
			check attached {board} model.b as board then
					board.un_setup_chess(r1, c1)
			end
		end
end
