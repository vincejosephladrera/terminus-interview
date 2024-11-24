class AdminController < ApplicationController
  def view
    @properties = Property.filter(params.slice(:address), params[:order_by] || "0").for_datatables
    @pagy, @properties = pagy(@properties, limit: 10)
  end

  def show
    @property = Property.find(params[:id])
  end
end