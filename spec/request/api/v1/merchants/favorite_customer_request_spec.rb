require 'rails_helper'

describe 'Merchants favorite customer' do
  context 'merchants/:id/favorite_customer', type: :request do
    it 'returns the customer with the highest number of successful transactions' do
      merchant = create(:merchant)
      id = merchant.id
      customer1 = create(:customer)
      customer2 = create(:customer)
      invoice1 = create(:invoice, merchant: merchant, customer: customer1)
      invoice2 = create(:invoice, merchant: merchant, customer: customer1)
      invoice3 = create(:invoice, merchant: merchant, customer: customer2)
      create(:transaction, invoice: invoice1, result: "success")
      create(:transaction, invoice: invoice2, result: "success")
      create(:transaction, invoice: invoice3, result: "success")

      get "/api/v1/merchants/#{id}/favorite_customer"

      json_fav_customer = JSON.parse(response.body)

      expect(response).to be_success
    end
  end
end
