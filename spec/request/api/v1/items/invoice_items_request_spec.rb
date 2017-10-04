require 'rails_helper'

describe "Items invoice_items" do
  context '/items/:id/invoice_items', type: :request do
    it 'returns all invoice_items for the selected item' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      invoice_items = create_list(:invoice_item, 3, item: item, invoice: invoice)
      id = item.id

      get "/api/v1/items/#{id}/invoice_items"

      json_invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_invoice_items.count).to eq(3)
    end
  end
end
