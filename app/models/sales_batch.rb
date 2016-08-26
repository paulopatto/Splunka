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

class SalesBatch < ActiveRecord::Base
  include Concerns::SalesFromFile

  has_many :sales, dependent: :destroy

  validates :batch_code, uniqueness: true, presence: false

  mount_uploader :attachment, SalesUploader
  after_create :process_data_file!
end
