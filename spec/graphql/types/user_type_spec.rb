require 'rails_helper'

describe Types::UserType do
  let(:user_type) { SuratDuniaSchema.types['User'] }
  let(:user) { create(:user) }

  describe 'schema' do
    subject { user_type }

    it { is_expected.to have_field('id').of_type('ID!') }
    it { is_expected.to have_field('name').of_type('String!') }
    it { is_expected.to have_field('email').of_type('String!') }
  end

  describe 'resolvers' do
    let(:obj) { user }
    let(:args) { {} }
    let(:ctx) { {} }
    subject { resolver_for(user_type).with(obj, args, ctx) }

    it { is_expected.to resolve_field('id').as user.id }
    it { is_expected.to resolve_field('name').as user.name }
    it { is_expected.to resolve_field('email').as user.email }
  end
end
