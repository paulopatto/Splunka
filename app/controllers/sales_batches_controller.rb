class SalesBatchesController < ApplicationController
  def index
    @sales_batches = SalesBatch.all
  end

  def new
    @sales_batch = SalesBatch.new
  end

  def create
    @batch = SalesBatch.create(upload_params)
    redirect_to sales_batch_path(@batch)
  end

  def show
    @sales_batch = SalesBatch.find(id)
  end

  protected

  def upload_params
    params.require(:sales_batch).permit(:attachment)
  end

  def id
    params.require(:id)
  end
end
