require 'rails_helper'

describe SalesBatchesController, type: :controller do
  describe '#index' do
    before do
      get :index
    end

    it 'returns with :success' do
      expect(response).to be_success
    end

    it 'render template :index' do
      expect(response).to render_template :index
    end

    context 'when does not have sales batches' do
      it 'assigns :sales_batches empty' do
        expect(assigns(:sales_batches)).to be_empty
      end
    end

    context 'when have any sales batches' do
      let(:registers_no) { 3 }
      before do
        registers_no.times.each {|x| create(:sales_batch) }
        get :index
      end

      it 'assigns :sales_batches with all batches' do
        expect(assigns(:sales_batches).count).to  eq registers_no
      end
    end
  end

  describe '#create' do
    let(:sales_batches_params) do
      {
        attachment: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'sales.txt'))
      }
    end


    before do
      allow(SalesBatchWorker).to receive(:perform_async)
      post :create, sales_batch: sales_batches_params
    end

    it 'batch persisted' do
      expect(assigns(:batch)).to be_persisted
    end

    it 'enqued job' do
      expect(SalesBatchWorker).to have_received(:perform_async)
    end
  end
end
