require 'rails_helper'

describe "Customers invoices" do
  context '/customers/:id/invoices', type: :request do
    it 'returns the merchant for the selected item' do
      merchant = create(:merchant)
      customer = create(:customer)
      invoices = create_list(:invoice, 3, merchant: merchant, customer: customer)
      id = customer.id

      get "/api/v1/customers/#{id}/invoices"

      json_invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_invoices.count).to eq(3)
    end
  end
end
