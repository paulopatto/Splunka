require 'csv'

class SalesBatchWorker
  include Sidekiq::Worker

  sidekiq_options queue: :sales

  CSV_HEADERS = %w(customer description unit_price amount address supplier)

  def perform(id)
    batch = SalesBatch.find(id)
    tsv = generate_tsv(batch.attachment.file.path)

    generate_sales_attrs(tsv).each do |sale_attr|
      batch.sales.create(sale_attr)
    end

    update_batch!(batch)
  end

  private

  def update_batch!(batch)
    total_revenue = calc_revenue(batch)

    batch.update_attributes({
      processed: true,
      revenue: total_revenue
    })
  end

  def calc_revenue(batch)
    batch.sales.map{|sale| sale.amount * sale.unit_price }.reduce(:+)
  end

  def generate_sales_attrs(tsv)
    tsv.map do |row|
      row.each_with_index.map do |value, index|
        Hash[ CSV_HEADERS[index], value ]
      end.reduce(&:merge)
    end
  end

  def generate_tsv(file_path)
    data = CSV.read(file_path, col_sep: "\t")
    data.delete_at(0)
    data
  end
end
