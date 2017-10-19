Rails.application.routes.draw do
  get '/events'  => "events#index"
  get '/events/:id' => "events#show"
  post '/add_comment'  => "events#add_comment"

  get '/user/:id'  => "users#show"
  patch '/users/:id'  => "users#update"
  get '/join/:id'  => "events#join"
  get '/cancelRSVP/:id' => "events#cancelRSVP"
  get '/events/edit/:id' => "events#edit_show"
  patch '/events/update/:id' => "events#update"
  delete '/delete/:id' => "events#delete"

  post '/logout'  => "sessions#destroy"
  post '/sessions/login'  => 'sessions#login'
  get ''   => 'sessions#index' 
  post '/sessions/create'  => 'sessions#create'
  post '/events/create'  => 'events#create'

end
