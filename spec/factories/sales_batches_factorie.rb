FactoryGirl.define do
  factory :sales_batch do
    attachment { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'sales.txt')) }
  end
end
