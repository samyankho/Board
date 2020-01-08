note
	description: "Summary description for {BISHOP_CHESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BISHOP_CHESS


inherit
	CHESS
		redefine
			out
		end

create
	make_bishop

feature --commands constructor
	make_bishop
		do
			bishop := 'B'
		end


feature --attribute
	bishop : CHARACTER


feature --output
 	out: STRING
 		--input an integer and return a string represent a type of chess
 	do
 		result := bishop.out
 	end

end
