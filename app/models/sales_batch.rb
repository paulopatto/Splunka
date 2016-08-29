# == Schema Information
#
# Table name: sales_batches
#
#  id         :integer          not null, primary key
#  attachment :string
#  revenue    :decimal(12, 2)   default(0.0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  batch_code :string
#  state      :string
#

class SalesBatch < ActiveRecord::Base
  has_many :sales, dependent: :destroy
  before_create :generate_batch_code
  after_create :queue!
  validates :batch_code, uniqueness: true

  mount_uploader :attachment, SalesUploader

  state_machine :state, :initial => :uploaded do

    after_transition on: :queue, do: :queue_on_sidekiq
    event :queue do
      transition :uploaded => :queued
    end

    event :process do
      transition [:queued, :processing] => :processing
    end

    event :resolve do
      transition :processing => :resolved
    end

    event :reject do
      transition :processing => :rejected
    end
  end

  def total_sales
    self.sales.count
  end

  #TODO: Comment this hack on codereview
  def as_json(options={})
    options[:methods] = [:total_sales]
    super
  end

  private

  def generate_batch_code
    self.batch_code = SecureRandom.uuid
  end

  def queue_on_sidekiq
    SalesBatchWorker.perform_async(self.id)
  end
end
