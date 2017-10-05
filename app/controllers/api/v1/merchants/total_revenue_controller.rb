class Api::V1::Merchants::TotalRevenueController < ApplicationController

  def index
    merchants = Merchant.where(filter = nil)
    # require "pry"; binding.pry
    render json: merchants.total_revenue
    # , serializer: TotalRevenueSerializer
  end
end
