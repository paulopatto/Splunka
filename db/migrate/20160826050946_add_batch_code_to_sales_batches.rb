class AddBatchCodeToSalesBatches < ActiveRecord::Migration
  def change
    add_column :sales_batches, :batch_code, :string
    add_index :sales_batches, :batch_code
  end
end
