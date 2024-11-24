class Property < ApplicationRecord
  include Filterable

  has_one :cert

  scope :for_datatables, -> {
    select(:id, :name, :display_name, :address, :market_value, :owner_address, :city, )
  }

  scope :filter_by_address, ->(address) {
    where("address ILIKE ?", "%#{address}%") 
  }


  scope :filter_order_by, -> (order_param) {
    order_param = order_param.split("_") 

    case order_param[0]
    when "1"
      order("name " + order_param[1])
    when "2"
      order("display_name " + order_param[1])
    when "3"
      order("address " + order_param[1])
    when "4"
      order("market_value " + order_param[1])
    when "5"
      order("owner_address " + order_param[1])
    when "6"
      order("city " + order_param[1])
    else
      order("name asc")
    end
  }

end
