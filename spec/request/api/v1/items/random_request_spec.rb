require 'rails_helper'

describe 'Random item' do
  context '/items/random', type: :request do
    it 'returns a random item' do
      merchant = create(:merchant)
      items = create_list(:item, 3, merchant: merchant)

      get '/api/v1/items/random'

      json_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_item.count).to eq(1)
    end
  end
end
