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

require 'rails_helper'

describe Sale, type: :model do
  it 'associates with sales_batch' do
    is_expected.to belong_to(:sales_batch)
  end

  context "validations" do
    subject { described_class.new }

    let(:required_fields) do
      [
        :customer,
        :description,
        :unit_price,
        :amount,
        :address,
        :supplier,
      ]
    end

    it 'validates all required fields' do
      required_fields.each do |field|
        is_expected.to validate_presence_of(field)
      end
    end
  end
end
