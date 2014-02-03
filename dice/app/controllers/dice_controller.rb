class DiceController < ApplicationController

	def new_game # establish session variables and initialize to nil for first check in view
		session[:goal] = nil							
		session[:status] = nil
		render "roll"
	end

	def roll_dice
		@dice = [rand(1..6), rand(1..6)]
		@sum = @dice[0] + @dice[1]

		# inspect url for query string params
		if params.has_key?(:goal) and params.has_key?(:status)
			@goal = params[:goal]
			@status = params[:status]
		end

		if @goal == nil and @status == nil	# first roll:
			if @sum == 7 or @sum == 11		# win if roll 7 or 11 first time
				@status = "win"
			elsif @sum == 2 or @sum == 3 or @sum == 12			
				@status = "lose"			# lose if roll 2, 3, or 12
			else
				@status = "hunt"			# enter the hunt otherwise
				@goal = @sum
			end
		else												
			if @sum == @goal		# if in hunt:
				@status = "win"		# => win if you roll goal.
			elsif @sum == 7			# => lose if roll 7.
				@status = "lose"	# => stay in the hunt otherwise
		end
		render "roll"
	end

end
