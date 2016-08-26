class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :customer
      t.string :description
      t.decimal :unit_price, precision: 12, scale: 2
      t.integer :amount
      t.string :address
      t.string :supplier
      t.references :sales_batch

      t.timestamps null: false
    end

    add_index :sales, :sales_batch_id
  end
end
