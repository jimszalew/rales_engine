class Api::V1::Transactions::RandomController < ApplicationController

  def show
    render json: Transaction.pluck.sample(1)
  end
end
