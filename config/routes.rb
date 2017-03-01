Rails.application.routes.draw do

	root 'organizations#index'


  get 'heads/create_head' => 'heads#create_head'
  post 'heads' => 'heads#save_head'

  get 'invited_voters/new' => 'invited_voters#new'
  post 'invited_voters' => 'invited_voters#create'

  
  resources :organizations do
  	resources :invites, only: [ :new, :create ]
  	resources :polls do
  		  member do
		    post 'upvote'
		    post 'downvote'
		    post 'zerovote'
		  end
  	end
  end	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
