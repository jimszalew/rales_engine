require 'rails_helper'

describe 'Random invoice_item' do
  context '/invoice_items/random', type: :request do
    it 'returns a random invoice_item' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      invoice_item1 = create_list(:invoice_item, 3, quantity: 12, item: item, invoice: invoice)

      get '/api/v1/invoice_items/random'

      json_invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_invoice_item.count).to eq(1)
    end
  end
end
