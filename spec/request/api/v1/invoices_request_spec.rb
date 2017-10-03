require 'rails_helper'

describe 'Invoices API', type: :request do
  it 'returns all of invoices' do
    merchant = create(:merchant)
    customer = create(:customer)
    create_list(:invoice, 3, merchant: merchant, customer: customer)

    get '/api/v1/invoices'

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(3)
  end

  it 'returns a single invoice by id' do
    merchant = create(:merchant)
    customer = create(:customer)
    id = create(:invoice, merchant: merchant, customer: customer).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(id)
  end
end
