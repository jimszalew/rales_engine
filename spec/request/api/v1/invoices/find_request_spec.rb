require 'rails_helper'

describe 'Find invoices' do
  context '/invoices/find?parameters', type: :request do
    it 'returns the invoice specified by id' do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant: merchant, customer: customer)

      get "/api/v1/invoices/find?id=#{invoice.id}"

      json_invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_invoice["id"]).to eq(invoice.id)
    end
  end

  context '/invoices/find_all?parameters', type: :request do
    it 'returns all invoices matching the status' do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice1 = create_list(:invoice, 3, status: "success", merchant: merchant, customer: customer)
      invoice2 = create_list(:invoice, 2, status: "failure", merchant: merchant, customer: customer)

      get "/api/v1/invoices/find_all?status=#{invoice1.first.status}"

      json_invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_invoices.count).to eq(3)
      expect(json_invoices.first["status"]).to eq(invoice1.first.status)
    end
  end
end
