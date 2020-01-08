note
	description: "Summary description for {BOARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOARD

inherit
	ANY


create  --constructor
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			n := 1
			noc  := 0
			cols := 4
			rows := 4
			create null.make
			create temp.make
--			create king.make_type(1)
--			create queen.make_type(2)
--			create knight.make_type(3)
--			create bishop.make_type(4)
--			create rook.make_type(5)
--			create pawn.make_type(6)
--			create free.make_type(7)
			create king.make_king
			create queen.make_queen
			create knight.make_knight
			create bishop.make_bishop
			create rook.make_rook
			create pawn.make_pawn
			create free.make_free
			create board.make_filled(null, cols, rows)
			create board2.make_filled (null, cols, rows)
			started := false
			over := false
			create  nof.make_empty
			create history.make
		end


feature -- model attributes
	noc : INTEGER
	cols:INTEGER
	rows: INTEGER
	board: ARRAY2[CHESS]
	board2: ARRAY2[CHESS]
	started: BOOLEAN
	temp: CHESS
	null: CHESS
--	king: CHESS
--	queen: CHESS
--	knight: CHESS
--	bishop: CHESS
--	rook: CHESS
--	pawn: CHESS
--	free: CHESS
	king: KING_CHESS
	queen: QUEEN_CHESS
	knight: KNIGHT_CHESS
	bishop: BISHOP_CHESS
	rook: ROOK_CHESS
	pawn: PAWN_CHESS
	free: FREE_CHESS
	over: BOOLEAN
	nof: ARRAY[CHESS]
	n: INTEGER
	history: HISTORY


feature -- model operations
	setup_chess(c: CHESS; row: INTEGER; col: INTEGER)
			 --Set up by adding a chess at (‘row‘, ‘col‘).
		require
			started: not started
			vaild_slot: check_vaild_slot (row, col)
			--notoccupied: board.item (row, col) ~ null

			do
					board.put (c, row, col)
					noc := noc + 1

			ensure
				numofchess: noc = old noc +1
			end


	un_setup_chess(row: INTEGER; col: INTEGER)
			do
				board.put (null, row, col)
				noc := noc - 1
			end


	check_vaild_slot(row:INTEGER; col: INTEGER):BOOLEAN
			do
				if
					row>=1 and row<=4 and col>=1 and col<=4
				then
					result := true
				end
			end

	start_game
			-- Start the game after setting up chess pieces.
		--require
		--	already_start: not started
			do
				if
						noc = 1
				then
						over := true
						started := true
				elseif
						noc = 0
				then
						over := true
						started := true
				else
						started := true
			end
		end

	un_start_game
			do
				if
						noc = 1
				then
						over := false
						started := false
				else
						started := false
						over := false
			end
			end

	reset_game
			-- Start to setup a new game.
		--require
		--	not_started: started
			do
				make
			end

	un_move_and_capture(r1: INTEGER; c1: INTEGER; r2: INTEGER; c2: INTEGER; first:CHESS ; SECOND:CHESS)
		do
			board.put (first, r1, c1)
			board.put (second, r2, c2)
			noc := noc + 1
		end

	move_and_capture(r1: INTEGER; c1: INTEGER; r2: INTEGER; c2: INTEGER)
			-- Move the chess at (‘r1‘, ‘c1‘), in a way that is valid,
			-- and capture the chess at (‘r2‘, ‘c2‘).
		require
			game_over: not over
			start: started
			vaild_slot: check_vaild_slot(r1,c1) and check_vaild_slot(r2,c2)
			occupied: board.item (r1,c1)/~null and board.item (r1,c1)/~null
			invaild_move: vaildmove (r1, c1, r2, c2)
			block: not block (r1, c1, r2, c2)
--		local
--			action: ACTION_MOVE_AND_CAPTURE
			do
--				check attached {BOARD} b as board then
--					action.make_move_and_capture (r1, c1, r2, c2)
--				end
					temp := board.item (r1, c1)
					board.put(null, r1, c1)
					board.put (temp, r2, c2)
					noc := noc - 1
					if
						noc = 1
					then
						over := true
					elseif
						lose
					then
						over := true
					end

			ensure
				numofchess: noc = old noc - 1
			end



	lose:BOOLEAN
--	require
--		n>0
		do
			across 1 |..| 4 is r loop
					across 1 |..| 4 is c loop
						if board.item (r,c) /~ null then
							moves(r,c)
--							nof.force (board.item (r,c),n)
--							n:= n+1
								across 1|..| 4 is i loop
									across 1|..| 4 is j loop
										if board2.item (i,j) ~ free and not block(r,c,i,j)then
											nof.force (board.item (i,j),n)
											n:= n+1
										end
									end
								end
							board2.make_filled (null, rows, cols)
					end
				end
			end
			if
				across nof is cursor all
						cursor ~ null
				end
				and nof.is_empty = false
			then
				result := true
			else
				result := false
 			end
 			n:=0
 			nof.make_empty
		end


	moves(row: INTEGER; col: INTEGER)
			-- Show all possible moves of the chess
	require
		--game_over: not over
		not_start: started
		vaild_slot: check_vaild_slot(row,col)
		occupied: board.item (row,col)/~null
			do
				temp := board.item (row, col)

				if temp ~ king then
					across (row-1) |..| (row+1) is r loop
						across (col-1) |..| (col+1) is c loop
							if check_vaild_slot(r,c) then
								board2.put (free, r, c)
							end
						end
					end
						board2.put (king, row, col)


				elseif temp ~ queen then
					across 1 |..| 4 is r loop
						across 1 |..| 4 is c loop
								if r = row or c=col or (row-r)=(col-c) or (r-row)=(c-col) or (row-r)=(c-col) or (r-row)=(col-c)then
									board2.put (free, r, c)
								end
						end
					end
						board2.put (queen, row, col)


				elseif temp ~ knight then
					across 1 |..| 4 is r loop
						across 1 |..| 4 is c loop
								if (r = row-1 and c = col+2)then
									board2.put (free, r, c)

								elseif (r = row+1 and c = col+2) then
									board2.put (free, r, c)

								elseif (r = row-2 and c = col+1) then
									board2.put (free, r, c)

								elseif (r = row-2 and c = col-1) then
									board2.put (free, r, c)

								elseif (r = row+2 and c = col+1) then
									board2.put (free, r, c)

								elseif (r = row+2 and c = col-1) then
									board2.put (free, r, c)

								elseif (r = row-1 and c = col-2) then
									board2.put (free, r, c)

								elseif (r = row+1 and c = col-2) then
									board2.put (free, r, c)
								end
						end
					end
						board2.put (knight, row, col)




				elseif temp ~ bishop then
					across 1 |..| 4 is r loop
						across 1 |..| 4 is c loop
								if (row-r)=(col-c) or (r-row)=(c-col) or (row-r)=(c-col) or (r-row)=(col-c)then
									board2.put (free, r, c)
								end
							end
						end
					board2.put (bishop, row, col)


				elseif temp ~ rook then
					across 1 |..| 4 is r loop
						across 1 |..| 4 is c loop
								if r = row then
									board2.put (free, r, c)
								elseif c=col then
									board2.put (free, r, c)
								end
							end
						end
					board2.put (rook, row, col)


				elseif temp ~ pawn then
					across 1 |..| 4 is r loop
						across 1 |..| 4 is c loop
								if (r = row-1 and c=col-1) then
									board2.put (free, r, c)
								elseif (r=row-1 and c=col+1)  then
									board2.put (free, r, c)
								end
							end
						end
					board2.put (pawn, row, col)
			end
end


vaildmove(r1:INTEGER; c1:INTEGER; r2:INTEGER; c2:INTEGER):BOOLEAN
	require
		vaild_slot: check_vaild_slot(r1,c1) and check_vaild_slot(r2,c2)
		do
			if board.item (r1, c1) ~ king then
				if (r1 = r2 and c1 = c2+1)then
					result := true

				elseif  (r1=r2) and (c1=c2)then
					result := false

				elseif (r1 = r2 and c1 = c2-1) then
					result := true

				elseif (r1 = r2+1 and c1 = c2+1) then
					result := true

				elseif (r1 = r2+1 and c1 = c2-1) then
					result := true

				elseif (r1 = r2+1 and c1 = c2) then
					result := true

				elseif (r1 = r2-1 and c1 = c2-1) then
					result := true

				elseif (r1 = r2-1 and c1 = c2) then
					result := true

				elseif (r1 = r2-1 and c1 = c2+1) then
					result := true
				else
					result := false
				end


			elseif board.item (r1, c1) ~ queen then
				if  (r1=r2) and (c1=c2)then
					result := false
				elseif r1 = r2 or c1=c2 or (r1-r2)=(c1-c2) or (r2-r1)=(c2-c1) or (r1-r2)=(c2-c1) or (r2-r1)=(c1-c2)then
					result := true
				else
					result := false
				end


			elseif board.item (r1, c1) ~ knight then
				if (r1 = r2-1 and c1 = c2+2)then
					result := true

				elseif (r1 = r2+1 and c1 = c2+2) then
					result := true

				elseif (r1 = r2-2 and c1 = c2+1) then
					result := true

				elseif (r1 = r2-2 and c1 = c2-1) then
					result := true

				elseif (r1 = r2+2 and c1 = c2+1) then
					result := true

				elseif (r1 = r2+2 and c1 = c2-1) then
					result := true

				elseif (r1 = r2-1 and c1 = c2-2) then
					result := true

				elseif (r1 = r2+1 and c1 = c2-2) then
					result := true
				else
					result := false
				end


			elseif board.item (r1, c1) ~ bishop then
				if  (r1=r2) and (c1=c2)then
					result := false
				elseif (r1-r2)=(c1-c2) or (r2-r1)=(c2-c1) or (r1-r2)=(c2-c1) or (r2-r1)=(c1-c2)then
					result := true
				else
					result := false
				end

			elseif board.item (r1, c1) ~ rook then
				if  (r1=r2) and (c1=c2)then
					result := false
				elseif r1 = r2 then
					result := true
				elseif c1=c2 then
					result := true
				else
					result := false
				end


			elseif board.item (r1, c1) ~ pawn then
				if  (r1=r2) and (c1=c2)then
					result := false
				elseif (r2 = r1-1 and c2=c1-1) then
					result := true
				elseif (r2=r1-1 and c2=c1+1)  then
					result := true
				end
			end
		end





	block(r1:INTEGER; c1:INTEGER; r2:INTEGER; c2:INTEGER):BOOLEAN
			local rowa, cola: INTEGER
		do
				rowa := r1-r2
				cola := c1-c2
			if board.item (r1, c1) ~ rook then

				if (r1=r2 and c1>c2 and cola.abs >1) then
						if ((cola.abs - 1)=1) and board.item (r1, c1-1) /~ null then
							result := true
						elseif ((cola.abs - 1)=2) and (board.item (r1, c1-1) /~ null or board.item (r1, c1-2) /~ null)then
							result := true
						end

				elseif (r1=r2 and c1<c2 and cola.abs >1) then
						if ((cola.abs - 1)=1) and board.item (r1, c1+1) /~ null then
							result := true
						elseif ((cola.abs - 1)=2) and (board.item (r1, c1+1) /~ null or board.item (r1, c1+2) /~ null)then
							result := true
						end

				elseif (c1=c2 and r1>r2 and rowa.abs >1) then
						if ((rowa.abs - 1)=1) and board.item (r1-1, c1) /~ null then
							result := true
						elseif ((rowa.abs - 1)=2) and (board.item (r1-2, c1) /~ null or board.item (r1-1, c1) /~ null) then
							result := true
						end

				elseif (c1=c2 and r2>r1 and rowa.abs >1) then
						if ((rowa.abs - 1)=1) and board.item (r1+1, c1) /~ null then
							result := true
						elseif ((rowa.abs - 1)=2) and (board.item (r1+2, c1) /~ null or board.item (r1+1, c1) /~ null) then
							result := true
						end

				else
					result := false
				end



			elseif board.item (r1, c1) ~ knight then
				if (r1-r2)=1 and (c1<c2) then
					if board.item ((r1-1), c1) /~ null or board.item ((r1-1), (c1+1)) /~ null then
						result := true
					else
						result := false
					end

				elseif (r1-r2)=1 and (c1>c2) then
					if board.item ((r1-1), c1) /~ null or board.item ((r1-1), (c1-1)) /~ null then
						result := true
					else
						result := false
					end

				elseif (r1-r2)= -1 and (c1<c2)then
					if board.item ((r1+1), c1) /~ null or board.item ((r1+1), (c1+1)) /~ null then
						result := true
					else
						result := false
					end

				elseif (r1-r2)= -1 and (c1>c2)then
					if board.item ((r1+1), c1) /~ null or board.item ((r1+1), (c1-1)) /~ null then
						result := true
					else
						result := false
					end

				elseif (r1-r2)= 2 then
					if board.item (r1-2, c1)/~null or board.item ((r1-1), c1) /~ null then
						result := true
					else
						result := false
					end

				elseif (r1-r2)= -2 then
					if board.item ((r1+2), c1)/~null or board.item ((r1+1), c1) /~ null then
						result := true
					else
						result := false
					end
				else
					result := false
				end




			elseif board.item (r1, c1) ~ queen then

						if (r2>r1) and (c2>c1) and (rowa.abs > 1) then
							if ((rowa.abs-1)=1) and board.item (r1+1, c1+1) /~ null then
								result := true
							elseif ((rowa.abs-1)=2) and board.item (r1+2, c1+2) /~ null then
								result := true
							else
								result := false
							end

						elseif (r2>r1) and (c2<c1) and (rowa.abs > 1) then
							if ((rowa.abs-1)=1) and board.item (r1+1, c1-1) /~ null then
								result := true
							elseif ((rowa.abs-1)=2) and board.item (r1+2, c1-2) /~ null then
								result := true
							else
								result := false
							end

						elseif (r2<r1) and (c2>c1) and (rowa.abs > 1) then
							if ((rowa.abs-1)=1) and board.item (r1-1, c1+1) /~ null then
								result := true
							elseif ((rowa.abs-1)=2) and board.item (r1-2, c1+2) /~ null then
								result := true
							else
								result := false
							end

						elseif (r2<r1) and (c2<c1) and (rowa.abs > 1) then
							if ((rowa.abs-1)=1) and board.item (r1-1, c1-1) /~ null then
								result := true
							elseif ((rowa.abs-1)=2) and board.item (r1-2, c1-2) /~ null then
								result := true
							else
								result := false
							end
						elseif (r1=r2 and c1>c2 and rowa.abs >1) then
								if ((cola.abs - 1)=1) and board.item (r1, c1-1) /~ null then
									result := true
								elseif ((cola.abs - 1)=2) and (board.item (r1, c1-1) /~ null or board.item (r1, c1-2) /~ null)then
									result := false
								end

						elseif (r1=r2 and c1<c2 and rowa.abs >1) then
								if ((cola.abs - 1)=1) and board.item (r1, c1+1) /~ null then
									result := true
								elseif ((cola.abs - 1)=2) and (board.item (r1, c1+1) /~ null or board.item (r1, c1+2) /~ null)then
									result := false
								end

						elseif (c1=c2 and r1>r2 and rowa.abs >1) then
								if ((rowa.abs - 1)=1) and board.item (r1-1, c1) /~ null then
									result := true
								elseif ((rowa.abs - 1)=2) and (board.item (r1-2, c1) /~ null or board.item (r1-1, c1) /~ null) then
									result := false
								end

						elseif (c1=c2 and r2>r1 and rowa.abs >1) then
								if ((rowa.abs - 1)=1) and board.item (r1+1, c1) /~ null then
									result := true
								elseif ((rowa.abs - 1)=2) and (board.item (r1+2, c1) /~ null or board.item (r1+1, c1) /~ null) then
									result := false
								end
						else
							result := false
						end

			elseif board.item (r1, c1) ~ bishop then

						if (r2>r1) and (c2>c1) and (rowa.abs > 1)then
							if ((rowa.abs-1)=1) and board.item (r1+1, c1+1) /~ null then
								result := true
							elseif ((rowa.abs-1)=2) and board.item (r1+2, c1+2) /~ null then
								result := true
							else
								result := false
							end

						elseif (r2>r1) and (c2<c1) and (rowa.abs > 1)then
							if ((rowa.abs-1)=1) and board.item (r1+1, c1-1) /~ null then
								result := true
							elseif ((rowa.abs-1)=2) and board.item (r1+2, c1-2) /~ null then
								result := true
							else
								result := false
							end

						elseif (r2<r1) and (c2>c1) and (rowa.abs > 1)then
							if ((rowa.abs-1)=1) and board.item (r1-1, c1+1) /~ null then
								result := true
							elseif ((rowa.abs-1)=2) and board.item (r1-2, c1+2) /~ null then
								result := true
							else
								result := false
							end

						elseif (r2<r1) and (c2<c1) and (rowa.abs > 1)then
							if ((rowa.abs-1)=1) and board.item (r1-1, c1-1) /~ null then
								result := true
							elseif ((rowa.abs-1)=2) and board.item (r1-2, c1-2) /~ null then
								result := true
							else
								result := false
							end

						end
				else
					result := false
				end
			end


end
