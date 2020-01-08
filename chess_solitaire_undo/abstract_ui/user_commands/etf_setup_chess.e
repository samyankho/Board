note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SETUP_CHESS
inherit
	ETF_SETUP_CHESS_INTERFACE
create
	make
feature -- command
	setup_chess(c: INTEGER_32 ; row: INTEGER_32 ; col: INTEGER_32)
		require else
			setup_chess_precond(c, row, col)
		local
			ch: CHESS
    do
			-- perform some update on the model state
			--model.default_update
			if
				model.b.started
			then
				model.set_error ("Error: Game already started")
    		elseif
				not model.b.check_vaild_slot (row, col)
			then
				model.set_error ("Error: (" + row.out + ", " + col.out + ") not a valid slot")
			elseif
				model.b.board.item (row, col) /~ model.b.null
			then
				model.set_error ("Error: Slot @ (" + row.out + ", " + col.out + ") already occupied")
			else

		    	    if
		    	    	c = 1
		    	    then
		    	    	create {KING_CHESS} ch.make_king
		    	    	model.setup_chess(ch, row, col)
		    	    elseif c = 2 then
		    	    	create {QUEEN_CHESS}ch.make_queen
		    	    	model.setup_chess(ch, row, col)
		    	    elseif c = 3 then
		    	    	create {KNIGHT_CHESS}ch.make_knight
		    	    	model.setup_chess(ch, row, col)
		    	    elseif c = 4 then
		    	    	create {BISHOP_CHESS}ch.make_bishop
		    	    	model.setup_chess(ch, row, col)
		    	    elseif c = 5 then
		    	    	create {ROOK_CHESS}ch.make_rook
		    	    	model.setup_chess(ch, row, col)
		    	    elseif c = 6 then
		    	    	create {PAWN_CHESS}ch.make_pawn
		    	    	model.setup_chess(ch, row, col)
		    	    end

		-- perform some update on the model state
--			create ch.make_type (c)
--			model.setup_chess(ch, row, col)
    	end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
