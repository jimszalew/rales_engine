require 'rails_helper'

describe 'Find transactions' do
  context '/transactions/find?parameters', type: :request do
    it 'returns the transaction specified by result' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      transaction = create(:transaction, invoice: invoice)

      get "/api/v1/transactions/find?result=#{transaction.result}"

      json_transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_transaction["result"]).to eq(transaction.result)
    end
  end

  context '/transactions/find_all?parameters', type: :request do
    it 'returns all transactions matching the name' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      transaction1 = create_list(:transaction, 3, result: "success", invoice: invoice)
      transaction2 = create_list(:transaction, 2, result: "failure", invoice: invoice)

      get "/api/v1/transactions/find_all?result=#{transaction1.first.result}"

      json_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_transactions.count).to eq(3)
      expect(json_transactions.first["result"]).to eq(transaction1.first.result)
    end
  end
end
