class Api::V1::InvoiceItems::InvoiceController < ApplicationController
  def index
    render json: InvoiceItem.find(params[:id]).invoice
  end
end
