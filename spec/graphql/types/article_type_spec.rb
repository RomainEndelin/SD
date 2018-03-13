require 'rails_helper'

describe Types::ArticleType do
  let(:article_type) { SuratDuniaSchema.types['Article'] }
  let(:author) { create(:user) }
  let(:article) { create(:article, author: author) }

  describe 'schema' do
    subject { article_type }

    it { is_expected.to have_field('id').of_type('ID!') }
    it { is_expected.to have_field('title').of_type('String!') }
    it { is_expected.to have_field('city').of_type('String') }
    it { is_expected.to have_field('country').of_type('String!') }
    it { is_expected.to have_field('picture').of_type('String!') }

    it { is_expected.to have_field('author').of_type('User!') }
  end

  describe 'resolvers' do
    let(:obj) { article }
    let(:args) { {} }
    let(:ctx) { {} }
    subject { resolver_for(article_type).with(obj, args, ctx) }

    it { is_expected.to resolve_field('id').as article.id }
    it { is_expected.to resolve_field('title').as article.title }
    it { is_expected.to resolve_field('city').as article.city }
    it { is_expected.to resolve_field('country').as article.country }
    it { is_expected.to resolve_field('picture').as article.picture }

    it { is_expected.to resolve_field('author').as author }
  end
end
