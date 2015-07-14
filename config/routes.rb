Rails.application.routes.draw do

  root :to => 'home#index'  
  resources :championships
  resources :games  do
    get :play, :on => :member
  end
    
  


end
