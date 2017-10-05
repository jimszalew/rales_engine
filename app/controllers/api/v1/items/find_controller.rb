class Api::V1::Items::FindController < ApplicationController

  def show
    if params.include?("unit_price")
      render json: Item.dollar_to_cents_one(params['unit_price'])
    else
      render json: Item.where(item_params).first
    end
  end

  def index
    if params.include?("unit_price")
      render json: Item.dollar_to_cents_all(params["unit_price"])
    else
      render json: Item.where(item_params)
    end
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
