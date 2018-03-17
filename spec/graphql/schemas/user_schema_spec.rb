require 'rails_helper'

describe 'SuratDuniaSchema - User' do
  let(:context) { {} }
  let(:variables) { {} }

  let(:user) { create(:user) }
  let!(:article) { create(:article, author: user) }

  subject { execute_query(query_string, context, variables) }

  let(:query_string) do
    %(
    query {
      articles {
        author {
          id
        }
      }
    })
  end

  it {
    is_expected.to match_nested_array(
      {
        data: {
          articles: [
            author: {
              id: user.id.to_s
            }
          ]
        }
      }
    )
  }
end
