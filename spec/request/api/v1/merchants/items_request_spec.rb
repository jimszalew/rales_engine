require 'rails_helper'

describe "Merchant's Items" do
  context '/merchants/:id/items', type: :request do
    it 'returns all items for the selected merchant' do
      merchant = create(:merchant)
      id = merchant.id
      items = create_list(:item, 3, merchant: merchant)

      get "/api/v1/merchants/#{id}/items"

      json_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_items.count).to eq(3)
    end
  end
end
