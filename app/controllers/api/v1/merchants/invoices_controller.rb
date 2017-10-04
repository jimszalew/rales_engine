class Api::V1::Merchants::InvoicesController < ApplicationController
  def index
    render json: Invoice.all
  end
end
