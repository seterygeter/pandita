Rails.application.routes.draw do

namespace 'api' do
  namespace 'v1' do 
    resources :users
    resources :movimientos
    resources :accounts
    resources :home
  end
end
end

