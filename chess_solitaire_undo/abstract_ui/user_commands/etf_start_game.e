note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_START_GAME
inherit
	ETF_START_GAME_INTERFACE
create
	make
feature -- command
	start_game
    	do
			-- perform some update on the model state
			--model.default_update
			if
					model.b.started
				then
					model.set_error ("Error: Game already started")
				else

					-- perform some update on the model state
					model.start_game

    	end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
