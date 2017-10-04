require 'rails_helper'

describe "Invoice's merchant" do
  context '/invoices/:id/merchant', type: :request do
    it 'returns the merchant for the selected invoice' do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      id = invoice.id


      get "/api/v1/invoices/#{id}/merchant"

      json_merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_merchant["name"]).to eq(merchant.name)
    end
  end
end
