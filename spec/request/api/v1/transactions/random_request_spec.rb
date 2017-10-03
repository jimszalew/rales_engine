require 'rails_helper'

describe 'Random transaction' do
  context '/transactions/random', type: :request do
    it 'returns a random transaction' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      transactions = create_list(:transaction, 3, invoice: invoice)

      get '/api/v1/transactions/random'

      json_transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_transaction.count).to eq(1)
    end
  end
end
