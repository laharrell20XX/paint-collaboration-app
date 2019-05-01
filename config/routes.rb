Rails.application.routes.draw do
  root 'canvases#index'
  get 'canvases/:id/:slug', to: 'canvases#show', as: 'canvas'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'
end
