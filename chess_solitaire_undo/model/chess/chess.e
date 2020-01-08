note
	description: "Summary description for {CHESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHESS

inherit
	ANY
		redefine
			out
		end

create
	make
	--, make_type

feature --commands constructor
	make
		do
			item := '.'
		end

--	make_type(type: INTEGER_32)
--		do
--			if type = 1 then
--				item := 'K'
--			elseif type = 2 then
--				item := 'Q'
--			elseif type = 3 then
--				item := 'N'
--			elseif type = 4 then
--				item := 'B'
--			elseif type = 5 then
--				item := 'R'
--			elseif type = 6 then
--				item := 'P'
--			elseif type = 7 then
--				item := '+'
--			end
--		end




feature --attribute
	item : CHARACTER
--	m: ETF_MODEL
	--arr: ARRAY[CHARACTER]


feature --output
 	out: STRING
 		--input an integer and return a string represent a type of chess
 	do
 		result := item.out
 	end




end
