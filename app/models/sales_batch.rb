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
  has_many :sales, dependent: :destroy
  before_create :generate_batch_code
  after_create :process_attachment
  validates :batch_code, uniqueness: true

  mount_uploader :attachment, SalesUploader

  private

  def generate_batch_code
    self.batch_code = SecureRandom.uuid
  end

  def process_attachment
    SalesBatchWorker.perform_async(self.id)
  end
end
