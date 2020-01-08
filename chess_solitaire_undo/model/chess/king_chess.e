note
	description: "Summary description for {KING_CHESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	KING_CHESS


inherit
	CHESS
		redefine
			out
		end

create
	make_king

feature --commands constructor
	make_king
		do
			king := 'K'
		end


feature --attribute
	king : CHARACTER


feature --output
 	out: STRING
 		--input an integer and return a string represent a type of chess
 	do
 		result := king.out
 	end




end
