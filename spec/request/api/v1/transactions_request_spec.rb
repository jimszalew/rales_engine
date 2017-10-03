require 'rails_helper'

describe 'Transactions API', type: :request do
  it 'returns all of transactions' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    create_list(:transaction, 3, invoice: invoice)

    get '/api/v1/transactions'

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(3)
  end

  it 'returns a single transactions by id' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    id = create(:transaction, invoice: invoice).id

    get "/api/v1/transactions/#{id}"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions["id"]).to eq(id)
  end
end
