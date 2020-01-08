note
	description: "Summary description for {ACTION_START_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ACTION_START_GAME

inherit
	ACTION

create
	make_start_game

feature
	make_start_game
		do
			make
		end

feature{ETF_MODEL}
	execute
		do
			if
					model.b.noc = 1
			then
				model.set_error ("Game Over: You Win!")
			elseif
					model.b.noc = 0
			then
				model.set_error ("Game Over: You Lose!")
			else
				model.set_error ("Game In Progress...")
			end
			check attached {board} model.b as board then
					board.start_game
			end
		end

	redo
		do
			execute
		end

	undo
		do
			model.set_error ("Game being Setup...")
			check attached {board} model.b as board then
					board.un_start_game
			end
		end

end
