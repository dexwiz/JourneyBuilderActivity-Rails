class ConsoleController < ApplicationController
	
	#out puts env variables for testing
	def env
		@id = ENV['CLIENT_ID']
		@secret = ENV['CLIENT_SECRET']
	end
end
