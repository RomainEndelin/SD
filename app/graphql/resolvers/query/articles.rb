module Resolvers::Query
  class Articles
    def call(_query, _args, _ctx)
      Article.all
    end
  end
end
