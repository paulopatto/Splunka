class CreateSalesBatches < ActiveRecord::Migration
  def change
    create_table :sales_batches do |t|
      t.string :attachment
      t.boolean :processed, default: false
      t.decimal :revenue, precision: 12, scale: 2, default: 0
      t.timestamps null: false
    end
  end
end
