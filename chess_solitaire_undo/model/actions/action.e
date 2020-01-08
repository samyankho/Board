note
	description: "Summary description for {ACTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ACTION


feature
	model : ETF_MODEL

feature
	make
		local
			mac: ETF_MODEL_ACCESS
		do
			model := mac.m
		end

feature{ETF_MODEL}
	--commands

	execute
		deferred end

	redo
		deferred end

	undo
		deferred end

end
