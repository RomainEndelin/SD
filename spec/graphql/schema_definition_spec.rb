require 'spec_helper'

describe 'SuratDuniaSchema' do
  it 'schema.graphql file should be up-to-date' do
    current_schema = SuratDuniaSchema.to_definition
    printout_schema = File.read(Rails.root.join('schema.graphql')).strip
    expect(printout_schema).to eq(current_schema), 'Update the printed schema with `bin/rake graphql:dump_schema`'
  end
end
