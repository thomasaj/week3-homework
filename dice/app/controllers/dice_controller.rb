class DiceController < ApplicationController

	def new_game	# establish session variables and initialize to nil for first check in view
		session[:goal] = nil							
		session[:status] = nil
		render "roll"
	end

	def roll_dice
		@dice = [rand(1..6), rand(1..6)]
		@sum = @dice[0] + @dice[1]
		if session[:goal] == nil and session[:status] == nil	# first roll:
			if @sum == 7 or @sum == 11							# win if roll 7 or 11 first time
				session[:status] = "win"
			elsif @sum == 2 or @sum == 3 or @sum == 12			# lose if roll 2, 3, or 12 first time
				session[:status] = "lose"
			else												# enter the hunt otherwise
				session[:status] = "hunt"
				session[:goal] = @sum
			end
		else												
			if @sum == session[:goal]							# if in hunt:
				session[:status] = "win"						# => win if you roll goal.
			elsif @sum == 7										# => lose if roll 7.
				session[:status] = "lose"						# => otherwise, stay in the hunt.
			end
		end
		render "roll"
	end

end
