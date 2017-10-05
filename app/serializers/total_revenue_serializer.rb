class TotalRevenueSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
    obj = object.to_f/100
    obj.to_s
  end

end
