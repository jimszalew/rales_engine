require 'rails_helper'

describe 'Customer API', type: :request do
  it 'returns all of the customers' do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_success

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(3)
  end

  it 'returns a single customer by id' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["id"]).to eq(id)
  end
end
