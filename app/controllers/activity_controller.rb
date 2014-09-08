class ActivityController < ApplicationController
  
  def configuration
    @host = request.host
	
	#Prevents JB from requesting legacy config.json file
	if params['format'] == 'js' then
		render "config"
	else
		render :nothing => true, :status => :service_unavailable
	end
  end
  
  def execute
    logger.debug "Execution posted"
    render nothing: true
  end
  
  def save
    logger.debug "Save posted"
    render nothing: true
  end
  
  def publish
    logger.debug "Validation posted"
    render nothing: true
  end
  
  def validate
    logger.debug "Validation posted"
    render nothing: true
  end
  
  def edit
  end
end
