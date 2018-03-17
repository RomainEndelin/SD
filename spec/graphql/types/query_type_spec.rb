require 'rails_helper'

describe Types::QueryType do
  let(:query_type) { SuratDuniaSchema.types['Query'] }

  describe 'schema' do
    subject { query_type }

    it { is_expected.to have_field('hello').of_type('String!') }
    it { is_expected.to have_field('articles').of_type('[Article]!') }
  end

  describe 'resolvers' do
    let(:obj) { nil }
    let(:args) { {} }
    let(:ctx) { {} }
    subject { resolver_for(query_type).with(obj, args, ctx) }

    it { is_expected.to resolve_field('hello').as 'world' }

    describe 'articles' do
      let!(:articles) { create_list(:article, 3) }

      it { is_expected.to resolve_field('articles').as Article.all }
    end
  end
end
