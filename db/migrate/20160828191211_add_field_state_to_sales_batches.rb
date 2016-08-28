class AddFieldStateToSalesBatches < ActiveRecord::Migration
  def change
    add_column :sales_batches, :state, :string
    remove_column :sales_batches, :processed
  end
end
