class ConsoleController < ApplicationController
	
	#out puts env variables for testing
	def env
		@id = ENV['CLIENT_ID']
		@secret = ENV['CLIENT_SECRET']
		@env = Rails.env
		@host = request.host
		@gems = Gem.loaded_specs.values.map {|x| "#{x.name} #{x.version}"}

	end
end
