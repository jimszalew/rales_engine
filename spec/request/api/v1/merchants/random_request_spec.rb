require 'rails_helper'

describe 'Random merchant' do
  context '/merchants/random', type: :request do
    it 'returns a random merchant' do
      merchants = create_list(:merchant, 3)

      get '/api/v1/merchants/random'

      json_merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_merchant.count).to eq(1)
    end
  end
end
