note
	description: "Summary description for {HISTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HISTORY

create
	make

feature{NONE}  -- create
	make
		do
--			create start.make_counter
			create {ARRAYED_LIST[ACTION]}history.make(0)
--			remove_right
--			history.count := 0
--			history.extend(start)
--			history.start
--			history.finish
		end

	history: LIST[ACTION]
		-- a history of list for all operations
--	start : ACTION_COUNTER

feature
	--queries

	item: ACTION
		--cursor pointing to the current operation
		require
				on_item
		do
			result := history.item
		end

	on_item: BOOLEAN
			-- cursor points to a valid operation
			-- cursor is not pointing to before or after
		do
			Result := not history.before and not history.after
		end

	after: BOOLEAN
			-- Is there no valid cursor position to the right of cursor?
		do
			Result := history.index = history.count
		end

	before: BOOLEAN
			-- Is there no valid cursor position to the left of cursor?
		do
			Result := history.index = 0
		end

	index:INTEGER
		do
			result := history.index
		end



feature --commands

	extend_history(op: ACTION)
			--move all operations to the right by one position, then extend a new one
		do
			remove_right
			history.extend (op)
			history.finish
		ensure
			history[history.count] = op
		end

	remove_right
			--move all operations to the right by one position
		do
			if not history.islast and not history.after then
				from
					history.forth
				until
					history.after
				loop
					history.remove
				end
			end
		end

	reset
		do
--			history.wipe_out
--			history.go_i_th (0)
--			remove_right
--			count := 0
			make
		end


	count: INTEGER
		do
			result:=history.count
		end



	forth
		require
			not after
		do
			history.forth
		end

	back
		require
			not before
		do
			history.back
		end

end
