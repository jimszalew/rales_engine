require 'rails_helper'

describe 'Random customer' do
  context '/customers/random', type: :request do
    it 'returns a random customer' do
      customers = create_list(:customer, 3)

      get '/api/v1/customers/random'

      json_customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_customer.count).to eq(1)
    end
  end
end
