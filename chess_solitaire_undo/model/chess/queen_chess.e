note
	description: "Summary description for {QUEEN_CHESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QUEEN_CHESS


inherit
	CHESS
		redefine
			out
		end

create
	make_queen

feature --commands constructor
	make_queen
		do
			queen := 'Q'
		end


feature --attribute
	queen : CHARACTER


feature --output
 	out: STRING
 		--input an integer and return a string represent a type of chess
 	do
 		result := queen.out
 	end

end
