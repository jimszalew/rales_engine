require 'rails_helper'

describe 'customers with pending invoices by merchant' do
  context 'merchants/:id/customers_with_pending_invoices', type: :request do
    it 'returns an all customers with pending invoices' do
      merchant1 = create(:merchant)
      customer1, customer2, customer3, customer4 = create_list(:customer, 4)
      invoice1 = create(:invoice, customer: customer1, merchant: merchant1)
      invoice2 = create(:invoice, customer: customer1, merchant: merchant1)
      invoice3 = create(:invoice, customer: customer2, merchant: merchant1)
      invoice4 = create(:invoice, customer: customer3, merchant: merchant1)

      create(:transaction, invoice: invoice1, result: "failed")
      create(:transaction, invoice: invoice2, result: "success")
      create(:transaction, invoice: invoice3, result: "failed")
      create(:transaction, invoice: invoice4, result: "failed")
      create(:transaction, invoice: invoice4, result: "success")

      get "/api/v1/merchants/#{merchant1.id}/customers_with_pending_invoices"
      cust_with_pend = JSON.parse(response.body)

      expect(response).to be_success
      expect(cust_with_pend.count).to eq(2)
      expect([cust_with_pend.first["id"], cust_with_pend.last["id"]]).to include(customer1.id, customer2.id)
    end
  end
end
