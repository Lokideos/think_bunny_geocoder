# frozen_string_literal: true

RSpec.describe Workers::EnqueueCoordinatesUpdate do
  let(:id) { 1 }
  let(:city) { 'City' }
  let(:ad) { { ad: { id: id, city: city } } }

  subject { described_class.new }

  it { is_expected.to be_processed_in :default }
  it { is_expected.to be_retryable 2 }
  it { is_expected.to save_backtrace 20 }

  describe '#perform' do
    let(:service) { Ads::UpdateCoordinatesService }

    before do
      allow(service).to receive(:call).with(ad)
    end

    it 'should call Ads::UpdateCoordinatesService service with correct attributes' do
      expect(service).to receive(:call).with(ad)

      subject.perform(ad)
    end
  end
end
