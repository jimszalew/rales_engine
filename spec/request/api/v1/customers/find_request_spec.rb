require 'rails_helper'

describe 'Find customers' do
  context '/customers/find?parameters', type: :request do
    it 'returns the customer specified by name' do
      customer = create(:customer)

      get "/api/v1/customers/find?first_name=#{customer.first_name}"

      json_customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_customer["first_name"]).to eq(customer.first_name)
    end
  end

  context '/customers/find_all?parameters', type: :request do
    it 'returns all customers matching the name' do
      customer1 = create_list(:customer, 3, first_name: "jimbo")
      customer2 = create_list(:customer, 2, first_name: "tron")

      get "/api/v1/customers/find_all?first_name=#{customer1.first.first_name}"

      json_customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_customers.count).to eq(3)
      expect(json_customers.first["first_name"]).to eq(customer1.first.first_name)
    end
  end
end
