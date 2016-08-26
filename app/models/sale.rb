# == Schema Information
#
# Table name: sales
#
#  id             :integer          not null, primary key
#  customer       :string
#  description    :string
#  unit_price     :decimal(12, 2)
#  amount         :integer
#  address        :string
#  supplier       :string
#  sales_batch_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Sale < ActiveRecord::Base
  belongs_to :sales_batch

  validates :customer,
    :description,
    :unit_price,
    :amount,
    :address,
    :supplier,
    presence: true
end
