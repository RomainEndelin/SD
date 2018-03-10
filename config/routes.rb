Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"

  root to: "home#index"
end
