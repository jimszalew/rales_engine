require 'rails_helper'

describe 'Random invoice' do
  context '/invoices/random', type: :request do
    it 'returns a random invoice' do
      merchant = create(:merchant)
      customer = create(:customer)
      invoices = create_list(:invoice, 3, merchant: merchant, customer: customer)

      get '/api/v1/invoices/random'

      json_invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_invoice.count).to eq(1)
    end
  end
end
