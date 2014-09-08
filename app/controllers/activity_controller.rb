class ActivityController < ApplicationController
  
  def configuration
    @host = request.host
	
	#Prevents JB from requesting legacy config.json file
	if params['format'] == 'js' then
		render "config"
	else
		render :nothing => true, :status => :service_unavailable
	end
    #render :nothing => true
  end
end
