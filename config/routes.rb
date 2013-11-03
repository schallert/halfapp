Halfapp::Application.routes.draw do
  root 'responses#index'

  get 'responses/sms', :to => 'responses#sms_inbound', :as => 'sms_inbound'
  resources :responses, :only => [:index]
end
