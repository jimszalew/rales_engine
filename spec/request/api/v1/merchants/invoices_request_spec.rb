require 'rails_helper'

describe "Merchant's Invoices" do
  context '/merchants/:id/invoices', type: :request do
    it 'returns all invoices for the selected merchant' do
      merchant = create(:merchant)
      customer = create(:customer)
      id = merchant.id
      invoices = create_list(:invoice, 3, merchant: merchant, customer: customer)

      get "/api/v1/merchants/#{id}/invoices"

      json_invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_invoices.count).to eq(3)
    end
  end
end
