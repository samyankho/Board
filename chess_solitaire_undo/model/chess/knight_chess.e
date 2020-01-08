note
	description: "Summary description for {KNIGHT_CHESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	KNIGHT_CHESS


inherit
	CHESS
		redefine
			out
		end

create
	make_knight

feature --commands constructor
	make_knight
		do
			knight := 'N'
		end


feature --attribute
	knight : CHARACTER


feature --output
 	out: STRING
 		--input an integer and return a string represent a type of chess
 	do
 		result := knight.out
 	end

end
