note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_REDO
inherit
	ETF_REDO_INTERFACE
create
	make
feature -- command
	redo
    	do
			-- perform some update on the model state
			--model.default_update
			if attached {BOARD} model.b as board then
				if board.history.after then
					model.set_error ("Error: Nothing to redo")
				else
					model.redo
				end
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
