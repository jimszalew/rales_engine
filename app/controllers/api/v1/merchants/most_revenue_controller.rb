class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    merchants = Merchant.where(filter = nil)
    render json: merchants.top_merchants(params[:quantity])
  end
end
