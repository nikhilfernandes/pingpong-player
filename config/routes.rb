Rails.application.routes.draw do

  root :to => 'home#index'  
  resources :championships do
    resources :games  do      
      resources :rounds do
        get :play, :on => :member
      end
    end
  end
    
  


end
