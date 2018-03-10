require 'rails_helper'

# This is a smoke-test for the GraphQL endpoint, to prevent regressions.
describe 'POST /graphql', type: :request do
  let(:params) { { query: "{ hello }" } }

  subject do
    post '/graphql', params: params
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
