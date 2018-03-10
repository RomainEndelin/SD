namespace :graphql do
  desc 'Save the GraphQL schema in a file'
  task dump_schema: :environment do
    # Get a string containing the definition in GraphQL IDL:
    schema_defn = SuratDuniaSchema.to_definition + "\n"
    schema_path = 'schema.graphql'
    File.write(Rails.root.join(schema_path), schema_defn)
    puts "Updated #{schema_path}"
  end
end
