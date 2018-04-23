require 'rails_helper'

# This is a smoke-test for the GraphQL endpoint, to prevent regressions.
describe 'POST /api/graphql', type: :request do
  let(:params) { { query: "{ hello }" } }

  subject do
    post '/api/graphql', params: params
    JSON.parse(response.body)
  end

  it {
    is_expected.to match(
      'data' => {
        'hello' => 'world'
      }
    )
  }
end
