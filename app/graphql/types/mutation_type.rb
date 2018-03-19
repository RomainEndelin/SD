Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :signinUser, function: Resolvers::SignInUser.new
end