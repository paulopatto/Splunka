require 'csv'

class SalesBatchWorker
  include Sidekiq::Worker

  sidekiq_options queue: :sales

  CSV_HEADERS = %w(customer description unit_price amount address supplier)

  def perform(id)
    batch = SalesBatch.find(id)

    batch.process!

    tsv = generate_tsv(batch.attachment.file.path)

    generate_sales_attrs(tsv).each do |sale_attr|
      batch.sales.create(sale_attr)
    end

    calc_revenue(batch)
    batch.resolve!
  # rescue => e
  #   logger.error "Erro de execução de job no sidekiq #{e}"
  #   batch.reject!
  end

  private

  def calc_revenue(batch)
    total_revenue = batch.sales.map do |sale|
      sale.amount * sale.unit_price
    end.reduce(:+)
    batch.update_attributes({ revenue: total_revenue })
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
