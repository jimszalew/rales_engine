require 'rails_helper'

describe "Invoice's customer" do
  context '/invoices/:id/customer', type: :request do
    it 'returns the customer for the selected invoice' do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      id = invoice.id

      get "/api/v1/invoices/#{id}/customer"

      json_customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_customer["first_name"]).to eq(customer.first_name)
    end
  end
end
