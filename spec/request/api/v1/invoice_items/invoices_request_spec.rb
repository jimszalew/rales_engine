require 'rails_helper'

describe "InvoiceItems invoices" do
  context '/invoice_items/:id/invoice', type: :request do
    it 'returns the invoice for the selected invoice_item' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      invoice_item = create(:invoice_item, item: item, invoice: invoice)
      id = invoice_item.id

      get "/api/v1/invoice_items/#{id}/invoice"

      json_invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_invoice["status"]).to eq(invoice.status)
    end
  end
end
