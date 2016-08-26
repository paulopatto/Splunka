class SalesController < ApplicationController
  def show
    @sale = Sale.find(id)
  end

  private

  def id
    params.require(:id)
  end
end
