class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    merchants = Merchant.where(filter = nil)
    render json: merchants.most_items_sold(params[:quantity])
  end
end
