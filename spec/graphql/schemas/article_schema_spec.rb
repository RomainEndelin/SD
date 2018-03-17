require 'rails_helper'

describe 'SuratDuniaSchema - Article' do
  let(:context) { {} }
  let(:variables) { {} }

  let!(:articles) { create_list(:article, 2) }

  subject { execute_query(query_string, context, variables) }

  let(:query_string) do
    %(
    query {
      articles {
        id
      }
    })
  end

  it {
    is_expected.to match_nested_array(
      {
        data: {
          articles: [
            { id: articles[0].id.to_s },
            { id: articles[1].id.to_s }
          ]
        }
      }
    )
  }
end
