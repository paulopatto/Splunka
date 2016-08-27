# == Schema Information
#
# Table name: sales_batches
#
#  id         :integer          not null, primary key
#  attachment :string
#  processed  :boolean          default(FALSE)
#  revenue    :decimal(12, 2)   default(0.0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  batch_code :string
#

require 'rails_helper'

describe SalesBatch, type: :model do
  it 'have many sales' do
    is_expected.to have_many :sales
  end

  context 'validates' do
    subject { build(:sales_batch) }

    it '#uniqness :batch_code' do
      is_expected.to validate_uniqueness_of :batch_code
    end
  end
end
