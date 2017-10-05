class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    render json: merchant.find_revenue(params[:date]), serializer: RevenueSerializer
  end
end
