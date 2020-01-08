note
	description: "Summary description for {PAWN_CHESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PAWN_CHESS


inherit
	CHESS
		redefine
			out
		end

create
	make_pawn

feature --commands constructor
	make_pawn
		do
			pawn := 'P'
		end


feature --attribute
	pawn : CHARACTER


feature --output
 	out: STRING
 		--input an integer and return a string represent a type of chess
 	do
 		result := pawn.out
 	end

end
