note
	description: "Summary description for {ACTION_RESET_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ACTION_RESET_GAME

inherit
	ACTION

create
	make_reset_game

feature
	make_reset_game
		do
			make
		end

feature{ETF_MODEL}
	execute
		do
			model.set_error ("Game being Setup...")
			check attached {board} model.b as board then
					board.reset_game
			end
			model.b.history.reset
		end

	redo
		do
			execute
		end

	undo
		do
--			model.set_error ("Error: Nothing to undo")
		end

end
