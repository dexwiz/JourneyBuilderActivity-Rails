JbMeltwater::Application.routes.draw do
  
  #env variables for testing
  get 'console/env' => 'console#env'
  
  #activity
  get 'activity/config' => 'activity#configuration'
  post 'activity/execute' => 'activity#execute'
  post 'activity/save' => 'activity#save'
  post 'activity/publish' => 'activity#publish'
  post 'activity/validate' => 'activity#validate'
  get 'activity' => 'activity#edit'
  get 'activity/index' => 'activity#edit'
  get 'activity/edit' => 'activity#edit'
end
