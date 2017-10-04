class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: Item.all
  end
end
