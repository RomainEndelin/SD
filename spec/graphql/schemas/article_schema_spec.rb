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
        edges {
          node {
            id
          }
        }
      }
    })
  end

  it {
    is_expected.to match_nested_array(
      {
        data: {
          articles: {
            edges: [
              { node: { id: articles[0].id.to_s } },
              { node: { id: articles[1].id.to_s } }
            ]
          }
        }
      }
    )
  }
end
