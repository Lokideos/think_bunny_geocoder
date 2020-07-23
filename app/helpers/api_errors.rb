# frozen_string_literal: true

module ApiErrors
  def error_response(error_messages)
    errors = ErrorSerializer.from_messages(error_messages)

    errors.to_json
  end
end
