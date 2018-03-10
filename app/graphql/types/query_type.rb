module Types
  QueryType = GraphQL::ObjectType.define do
    name 'Query'

    field :hello, !types.String do
      description 'A dummy field, useful for smoke-testing GraphQL'
      resolve ->(_, _, _) { 'world' }
    end
  end
end
