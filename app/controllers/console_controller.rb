class ConsoleController < ApplicationController
  def index
  end
	
	def list
		@logs = ActivityLog.all
	end
  
  def fire
    
    @logHash = Hash.new
    
    RestClient.log =
    Object.new.tap do |proxy|
      def proxy.<<(message)
        Rails.logger.info message
      end
    end
		
    payload = {
      clientId: ENV['CLIENT_ID'], 
      clientSecret: ENV['CLIENT_SECRET']
    }

    #Gets token
    authReponse = JSON.parse(RestClient.post 'https://auth.exacttargetapis.com/v1/requestToken', payload.to_json, :content_type => 'application/json')
    logger.debug authReponse
    @logHash[:authReponse] = authReponse 
    token = 'Bearer ' + authReponse['accessToken']
    
    #Upserts to MasterDE
    #Field Name, Type, Options
    #SubscriberKey, Text, Primary, Not Nullable
    #EmailAddress, Email, Not Primary, Not Nullabe
    deKey = ENV['MASTER_DE_KEY']
    contactKey = params[:k]
    emailAddress = params[:e]
    payload = {'values' => {'EmailAddress' => emailAddress}}
    masterDEReponse = JSON.parse(RestClient.put "https://www.exacttargetapis.com/hub/v1/dataevents/key:#{deKey}/rows/SubscriberKey:#{contactKey}", payload.to_json, :Authorization => token, :content_type => 'application/json')
    logger.debug masterDEReponse 
    @logHash[:masterDEReponse] = masterDEReponse
    #Posts to trigger DE
    #Field Name, Type, Options
    #SubscriberKey, Text, Not Nullabe, Not Primary
    #EmailAddres, Email Address, Not Nullable, Not Primary
    #Value, Text, Nullable, Not Primary

    payload = {
      'EventDefinitionKey' => ENV['EVENT_DEFINITION_KEY'],
      'ContactKey' => contactKey,
      'Data' => {
        'SubscriberKey' => contactKey,
        'EmailAddress' => emailAddress,
        'Value' => 'testValue'
      }
    }
    triggerReponse = RestClient.post 'https://www.exacttargetapis.com/interaction-experimental/v1/events', payload.to_json, :Authorization => token, :content_type => 'application/json'
    
		# Currently payload is returned wrapped in double quotes which makes Ruby string parsing throw a hissyfit
		# Hack to remove escaped double quotes around payload and escaped whitespace embeeded
		triggerReponse = JSON.parse(triggerReponse.gsub(/^\"|\"?$|\\n|\\r|\\/, ''))
		@logHash[:triggerReponse] = triggerReponse
 end 
end
