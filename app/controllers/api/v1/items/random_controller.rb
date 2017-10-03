class Api::V1::Items::RandomController < ApplicationController

  def show
    render json: Item.pluck.sample(1)
  end
end
