note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVE_AND_CAPTURE
inherit
	ETF_MOVE_AND_CAPTURE_INTERFACE
create
	make
feature -- command
	move_and_capture(r1: INTEGER_32 ; c1: INTEGER_32 ; r2: INTEGER_32 ; c2: INTEGER_32)
    	do
			-- perform some update on the model state
			--model.default_update
			if
					model.b.over
				then
					model.set_error ("Error: Game already over")

				elseif
					not model.b.started
 				then
					model.set_error ("Error: Game not yet started")

				elseif
					not model.b.check_vaild_slot (r1, c1)
				then
					model.set_error ("Error: (" + r1.out + ", " + c1.out + ") not a valid slot")

				elseif
					not model.b.check_vaild_slot (r2, c2)
				then
					model.set_error ("Error: (" + r2.out + ", " + c2.out + ") not a valid slot")

				elseif
					model.b.board.item (r1, c1) ~ model.b.null
				then
					model.set_error ("Error: Slot @ ("+ r1.out + ", " + c1.out +") not occupied")

				elseif
					model.b.board.item (r2, c2) ~ model.b.null
				then
					model.set_error ("Error: Slot @ ("+ r2.out + ", " + c2.out +") not occupied")

				elseif
					not model.b.vaildmove (r1, c1, r2, c2)
				then
					model.set_error ("Error: Invalid move of "+model.b.board.item (r1, c1).out +" from ("+r1.out+", "+c1.out+") to ("+r2.out+", "+ c2.out+")")

				elseif
					model.b.block (r1, c1, r2, c2)
				then
					model.set_error ("Error: Block exists between (" + r1.out + ", " + c1.out + ") and (" + r2.out + ", " + c2.out +")")
--				elseif
--						model.lose
--					then
--						model.set_error ("Game Over: You Lose!")
--						model.over := true
				else
					model.move_and_capture(r1, c1, r2, c2)

    	end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
