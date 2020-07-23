# frozen_string_literal: true

RSpec.describe Application, type: :routes do
  describe 'POST /v1/geocode' do
    let(:id) { 1 }
    let(:city) { 'City' }
    let(:ad) { { ad: { id: id, city: city } } }
    let(:update_coordinates_worker) { Workers::EnqueueCoordinatesUpdate }

    before do
      header 'Content-Type', 'application/json'
    end

    context 'with valid parameters' do
      it 'returns a correct json' do
        post '/v1/geocode', ad.to_json

        expect(last_response.status).to eq(200)
        expect(response_body['status']).to eq('ok')
      end

      it 'enqueue Workers::EnqueueCoordinatesUpdate worker' do
        expect(update_coordinates_worker).to receive(:perform_async).with(ad)

        post '/v1/geocode', ad.to_json
      end
    end

    context 'with invalid parameters' do
      let(:incorrect_ad) { { ad: {} } }

      it 'should return an error' do
        post '/v1/geocode', incorrect_ad.to_json

        expect(last_response.status).to eq(422)
        expect(response_body['errors'])
          .to include('detail' => 'В запросе отсутствуют необходимые параметры')
      end
    end
  end
end
