require 'rails_helper'

describe 'Transactions API', type: :request do
  it 'returns all of transactions' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    create_list(:transaction, 3, invoice_id: invoice.id)

    get '/api/v1/transactions'

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(3)
  end

  it 'returns a single transactions by id' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    id = create(:transaction, invoice_id: invoice.id).id

    get "/api/v1/transactions/#{id}"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions["id"]).to eq(id)
  end
end
