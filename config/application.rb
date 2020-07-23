# frozen_string_literal: true

class Application < Roda
  def self.root
    File.expand_path('..', __dir__)
  end

  def self.environment
    ENV.fetch('RACK_ENV').to_sym
  end

  plugin :error_handler do |e|
    case e
    when Validations::InvalidParams, KeyError
      response['Content-Type'] = 'application/json'
      response.status = 422
      error_response I18n.t(:missing_parameters, scope: 'api.errors')
    else
      raise
    end
  end
  plugin(:not_found) { { error: 'Not found' } }
  plugin :environments
  plugin(:json_parser)

  include Validations
  include ApiErrors

  route do |r|
    r.root do
      response['Content-Type'] = 'application/json'
      response.status = 200
      { status: 'ok' }.to_json
    end

    r.on 'v1' do
      r.on 'geocode' do
        r.post do
          ad_values = JSON(request.body.read)
          ad_params = validate_with!(GeocodeParamsContract, values: ad_values)
          Ads::UpdateCoordinatesService.call(ad_params.values.to_h)

          response['Content-Type'] = 'application/json'
          response.status = 200
          { status: 'ok' }.to_json
        end
      end

      r.get 'favicon.ico' do
        'no icon'
      end
    end
  end

  private

  def params
    request.params
  end
end
