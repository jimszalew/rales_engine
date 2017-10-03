require 'rails_helper'

describe 'Find items' do
  context '/items/find?parameters', type: :request do
    it 'returns the item specified by name' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)

      get "/api/v1/items/find?name=#{item.name}"

      json_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_item["name"]).to eq(item.name)
    end
  end

  context '/items/find_all?parameters', type: :request do
    it 'returns all items matching the name' do
      merchant = create(:merchant)
      item1 = create_list(:item, 3, name: "cake", merchant: merchant)
      item2 = create_list(:item, 2, name: "pie", merchant: merchant)

      get "/api/v1/items/find_all?name=#{item1.first.name}"

      json_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_items.count).to eq(3)
      expect(json_items.first["name"]).to eq(item1.first.name)
    end
  end
end
