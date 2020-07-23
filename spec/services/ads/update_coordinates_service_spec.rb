# frozen_string_literal: true

RSpec.describe Ads::UpdateCoordinatesService do
  let(:id) { 1 }
  let(:city) { 'City' }
  let(:coordinates) { [10.0, 10.0] }
  let(:service) { double('Http Client Service') }

  before do
    allow(AdsService::HttpClient).to receive(:new).and_return(service)
    allow(service).to receive(:update_coordinates)
    allow(Geocoder).to receive(:geocode).with(city).and_return(coordinates)
  end

  subject { described_class }

  context 'with valid parameters' do
    let(:correct_ad) { { ad: { id: id, city: city } } }
    let(:correct_response) { { id: id, coordinates: coordinates } }

    it 'should trigger #update_coordinates with correct parameters' do
      expect(service).to receive(:update_coordinates).with(correct_response.to_json).once

      subject.call(correct_ad)
    end
  end

  context 'with invalid parameters' do
    let(:incorrect_ad) { { ad: {} } }

    it 'should raise KeyError' do
      expect { subject.call(incorrect_ad) }.to raise_error KeyError
    end
  end
end
