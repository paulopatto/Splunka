require 'csv'

module Concerns
  module SalesFromFile
    extend ActiveSupport::Concern

    CSV_HEADERS = %w(customer description unit_price amount address supplier)

    private

    #TODO: Refactor this to use uploader filename
    #TODO: Refactor this to move to Sidekiq
    #TODO: Refactor this to reduce method lines
    def process_data_file!
      filename = self.attachment.file.file
      data = CSV.read(filename, col_sep: "\t")
      data.delete_at(0)

      sales_attrs = data.map do |row|
        row.each_with_index.map do |value, index|
          Hash[ CSV_HEADERS[index], value ]
        end.reduce(&:merge)
      end

      sales_attrs.each do |sale_attr|
        self.sales.create(sale_attr)
      end

      total_revenue = self.sales.map{|sale| sale.amount * sale.unit_price }.reduce(:+)
      self.update_attributes({
        processed: true,
        revenue: total_revenue,
        batch_code: SecureRandom.uuid
      })
    end
  end
end
