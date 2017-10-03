class Api::V1::Merchants::RandomController < ApplicationController

  def show
    render json: Merchant.pluck.sample(1)
  end
end
