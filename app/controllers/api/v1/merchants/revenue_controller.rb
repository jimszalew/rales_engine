class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    render json: merchant.find_revenue(params[:date]), serializer: RevenueSerializer
  end

  def index
    merchants = Merchant.all
    render json: merchants.total_revenue(params[:date]), serializer: TotalRevenueSerializer
  end
end
