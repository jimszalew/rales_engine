class Api::V1::InvoiceItems::FindController < ApplicationController

  def show
    if params.include?("unit_price")
    render json: InvoiceItem.dollar_to_cents_one(params["unit_price"])
    else
      render json: InvoiceItem.find_by(invoice_item_params)
    end
  end

  def index
    if params.include?("unit_price")
       render json: InvoiceItem.dollar_to_cents_all(params["unit_price"])
    else
      render json: InvoiceItem.where(invoice_item_params)
    end
  end

  private

  def invoice_item_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
