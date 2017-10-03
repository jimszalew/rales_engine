class Api::V1::Invoices::RandomController < ApplicationController

  def show
    render json: Invoice.pluck.sample(1)
  end
end
