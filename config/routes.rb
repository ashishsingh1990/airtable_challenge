Rails.application.routes.draw do
  # Main root path
  get "/copy/:key", to: 'copy#index', :constraints  => { :key => /[0-z\.]+/ }
  # root to: 'copy#index'
end
