Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'country_guess', :to => 'names#search'
  get 'calculator', :to => 'calculator#compute'
end
