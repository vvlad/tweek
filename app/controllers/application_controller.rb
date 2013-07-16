class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::StrongParameters
  respond_to :json
  protected

  def respond_with_resource(resource, options={})

    if resource.errors.empty?
      render({ json: resource }.merge(options))
    else
      render({ json: { errors: resource.errors }, status: :unprocessable_entity}.merge(options))
    end

  end

end
