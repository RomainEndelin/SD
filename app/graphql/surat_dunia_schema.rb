SuratDuniaSchema = GraphQL::Schema.define do
  MAX_DEPTH = 10 # The connection pattern tends to increase depth rapidly

  query(Types::QueryType)
  use GraphQL::Guard.new
  use BatchLoader::GraphQL

  max_depth MAX_DEPTH

  type_resolver = lambda do |_type, obj, _ctx|
    type = "::Types::#{obj.class}Type".safe_constantize
    return type if type.present?

    raise ArgumentError.new("Cannot resolve type for class #{obj.class.name}")
  end
  resolve_type type_resolver

  # These types are not linked to the schema, thus must be loaded explicitly
  orphan_types []
end
