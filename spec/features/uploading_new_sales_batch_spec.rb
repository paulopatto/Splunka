require 'rails_helper'

feature 'Uploading and creating new Sales Batch', type: :feature do
  let(:sales_batch_file_path) { 'spec/fixtures/sales.txt' }

  before do
    visit root_path
    attach_file 'sales_batch[attachment]', File.absolute_path(sales_batch_file_path)
    click_on 'Enviar'
  end

  it '' do

  end
end
