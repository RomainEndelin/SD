module Types
  ArticleType = GraphQL::ObjectType.define do
    name 'Article'

    field :id, !types.ID
    field :title, !types.String 
    field :city, types.String 
    field :country, !types.String 
    field :picture, !types.String 

    field :author, !UserType
  end
end
