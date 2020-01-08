note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVES
inherit
	ETF_MOVES_INTERFACE
create
	make
feature -- command
	moves(row: INTEGER_32 ; col: INTEGER_32)
    	do
			-- perform some update on the model state
			if
				model.b.over
			then
				model.set_error ("Error: Game already over")
			elseif
				not model.b.started
			then
				model.set_error ("Error: Game not yet started")
			elseif
				not model.b.check_vaild_slot(row, col)
			then
				model.set_error ("Error: (" + row.out + ", " + col.out + ") not a valid slot")
			elseif
				model.b.board.item (row, col) ~ model.b.null
			then
				model.set_error ("Error: Slot @ (" + row.out + ", " + col.out + ") not occupied")


			else
			model.moves(row, col)
    	end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
