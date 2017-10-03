require 'rails_helper'

describe 'InvoiceItem API', type: :request do
  it 'returns all of invoice_items' do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    create_list(:invoice_item, 3, item: item, invoice: invoice)

    get '/api/v1/invoice_items'

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(3)
  end

  it 'returns a single invoice_item by id' do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    id = create(:invoice_item, item: item, invoice: invoice).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["id"]).to eq(id)
  end
end
