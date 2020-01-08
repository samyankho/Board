note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_UNDO
inherit
	ETF_UNDO_INTERFACE
create
	make
feature -- command
	undo
    	do
			-- perform some update on the model state
			--model.default_update
			if attached {BOARD} model.b as board then
				if board.history.before then
					model.set_error ("Error: Nothing to undo")
				else
					model.undo
				end
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
