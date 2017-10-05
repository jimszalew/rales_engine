require 'rails_helper'

describe 'customers favorite merchant' do
  context 'customers/:id/favorite_merchant', type: :request do
    it 'returns a customers favorite merchant' do
      customer = create(:customer)
      id = customer.id
      merchant1, merchant2 = create_list(:merchant, 2)
      invoice1 = create(:invoice, merchant: merchant1, customer: customer)
      invoice2 = create(:invoice, merchant: merchant2, customer: customer)
      transaction = create(:transaction, invoice: invoice1, result: "success")
      transaction = create(:transaction, invoice: invoice1, result: "success")
      transaction = create(:transaction, invoice: invoice2, result: "success")

      get "/api/v1/customers/#{id}/favorite_merchant"

      merchant_json = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant_json['id']).to eq(merchant1.id)
    end
  end
end
