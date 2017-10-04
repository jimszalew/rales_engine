require 'rails_helper'

describe "InvoiceItems item" do
  context '/invoice_items/:id/item', type: :request do
    it 'returns the item for the selected invoice_item' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      invoice_item = create(:invoice_item, item: item, invoice: invoice)
      id = invoice_item.id

      get "/api/v1/invoice_items/#{id}/item"

      json_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_item["name"]).to eq(item.name)
    end
  end
end
