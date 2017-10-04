require 'rails_helper'

describe "Items merchant" do
  context '/items/:id/merchant', type: :request do
    it 'returns the merchant for the selected item' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      invoice_items = create_list(:invoice_item, 3, item: item, invoice: invoice)
      id = item.id

      get "/api/v1/items/#{id}/merchant"

      json_merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_merchant["name"]).to eq(merchant.name)
    end
  end
end
