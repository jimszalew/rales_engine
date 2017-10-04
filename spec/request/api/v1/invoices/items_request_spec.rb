require 'rails_helper'

describe "Invoice's items" do
  context '/invoices/:id/items', type: :request do
    it 'returns the items for the selected invoice' do
      merchant = create(:merchant)
      customer = create(:customer)
      items = create_list(:item, 3, merchant: merchant)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      id = invoice.id

      get "/api/v1/invoices/#{id}/items"

      json_items = JSON.parse(response.body)

      expect(response).to be_success
    end
  end
end
