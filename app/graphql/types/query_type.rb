module Types
  QueryType = GraphQL::ObjectType.define do
    name 'Query'

    field :hello, !types.String do
      description 'A dummy field, useful for smoke-testing GraphQL'
      resolve ->(_, _, _) { 'world' }
    end

    connection :articles, ArticleType.connection_type do
      resolve Resolvers::Query::Articles.new
    end
  end
end
