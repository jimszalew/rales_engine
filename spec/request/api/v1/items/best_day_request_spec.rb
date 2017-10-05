require 'rails_helper'

describe 'items best_day' do
  context 'items/:id/best_day', type: :request do
    it 'returns the day with the most transactions' do
      customer = create(:customer)
      merchant = create(:merchant)
      item1, item2 = create_list(:item, 2, merchant: merchant)
      invoice1 = create(:invoice, merchant: merchant, customer: customer, created_at: '2011-02-11 00:52:02 UTC')
      invoice2 = create(:invoice, merchant: merchant, customer: customer,  created_at: '2012-02-11 00:52:02 UTC')
      invoice3 = create(:invoice, merchant: merchant, customer: customer,  created_at: '2012-03-11 00:52:02 UTC')
      create(:invoice_item, invoice: invoice1, quantity: 10, item: item1)
      create(:invoice_item, invoice: invoice2, quantity: 10, item: item2)
      create(:invoice_item, invoice: invoice2, quantity: 10, item: item2)

      get "/api/v1/items/#{item1.id}/best_day"

      item_json = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_json['best_day'].to_datetime).to eq(invoice1.created_at.to_datetime)
    end
  end
end
