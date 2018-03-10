require 'rails_helper'

describe Types::QueryType do
  let(:query_type) { SuratDuniaSchema.types['Query'] }

  describe 'schema' do
    subject { query_type }

    it { is_expected.to have_field('hello').of_type('String!') }
  end
end
