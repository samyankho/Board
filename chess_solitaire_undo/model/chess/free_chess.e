note
	description: "Summary description for {FREE_CHESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FREE_CHESS


inherit
	CHESS
		redefine
			out
		end

create
	make_free

feature --commands constructor
	make_free
		do
			free := '+'
		end


feature --attribute
	free : CHARACTER


feature --output
 	out: STRING
 		--input an integer and return a string represent a type of chess
 	do
 		result := free.out
 	end

end
