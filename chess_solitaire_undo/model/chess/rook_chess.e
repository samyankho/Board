note
	description: "Summary description for {ROOK_CHESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROOK_CHESS


inherit
	CHESS
		redefine
			out
		end

create
	make_rook

feature --commands constructor
	make_rook
		do
			rook := 'R'
		end


feature --attribute
	rook : CHARACTER


feature --output
 	out: STRING
 		--input an integer and return a string represent a type of chess
 	do
 		result := rook.out
 	end

end
