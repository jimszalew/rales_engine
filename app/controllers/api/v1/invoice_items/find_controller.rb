class Api::V1::InvoiceItems::FindController < ApplicationController

  def show
    render json: InvoiceItem.find_by(invoice_params)
  end

  def index
    render json: InvoiceItem.where(invoice_params)
  end

  private

  def invoice_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
