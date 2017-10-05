class RevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    obj = object.to_f/100
    obj.to_s
  end
end
