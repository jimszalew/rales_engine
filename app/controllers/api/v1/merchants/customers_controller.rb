class Api::V1::Merchants::CustomersController < ApplicationController
  def index
    render json: Merchant.find(params[:id]).customers_with_pending_invoices
  end

  def show

  end
end
