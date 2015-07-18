Rails.application.routes.draw do

  root :to => 'home#index'  
  resources :championships do
    resources :games  do      
      resources :rounds do
        put :play, :on => :member
      end
    end
  end
    
  


end
