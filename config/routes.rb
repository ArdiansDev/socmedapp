Rails.application.routes.draw do

  namespace 'api' do 
    namespace 'v1' do 
      resources :message
      resources :users, param: :_username
      get '/message/open', to: 'message#show'
      post '/login', to: 'authentication#login'
      get '/*a', to: 'application#not_found'
      end
    end 
   end