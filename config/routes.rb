Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/api/graphql"
  end

  devise_for :user, skip: :all, skip_helpers: true
  
  post "/api/graphql", to: "graphql#execute"

  root to: "pages#home"

  get "*path", to: "pages#home"
end
