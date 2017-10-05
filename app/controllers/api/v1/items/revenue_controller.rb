class Api::V1::Items::RevenueController < ApplicationController

  def index
    items = Item.where(filter = nil)
    render json: items.most_rev(params[:quantity])
  end
end
