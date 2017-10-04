require 'rails_helper'

describe "Invoice's invoice_items" do
  context '/invoices/:id/invoice_items', type: :request do
    it 'returns the invoice_items for the selected invoice' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      id = invoice.id
      create_list(:invoice_item, 3, item: item, invoice: invoice)

      get "/api/v1/invoices/#{id}/invoice_items"

      json_invoice_items = JSON.parse(response.body)

      expect(response).to be_success
    end
  end
end
