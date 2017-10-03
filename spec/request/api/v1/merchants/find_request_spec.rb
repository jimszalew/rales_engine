require 'rails_helper'

describe 'Find merchants' do
  context '/merchants/find?parameters', type: :request do
    it 'returns the merchant specified by name' do
      merchant = create(:merchant)

      get "/api/v1/merchants/find?name=#{merchant.name}"

      json_merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_merchant["name"]).to eq(merchant.name)
    end
  end

  context '/merchants/find_all?parameters', type: :request do
    it 'returns all merchants matching the name' do
      merchant1 = create_list(:merchant, 3, name: "jimbo")
      merchant2 = create_list(:merchant, 2, name: "tron")

      get "/api/v1/merchants/find_all?name=#{merchant1.first.name}"

      json_merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_merchants.count).to eq(3)
      expect(json_merchants.first["name"]).to eq(merchant1.first.name)
    end
  end
end
