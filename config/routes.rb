Rails.application.routes.draw do
  resources :players do
    member do
      post 'transfer'
      post 'withdraw'
      post 'deposit'
    end
  end

  root "players#index"
end
