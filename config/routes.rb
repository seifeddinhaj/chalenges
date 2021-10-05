Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'name/guesser', :to => 'names#search'
  get 'calculator', :to => 'calculator#compute'
end
