# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include Knock::Authenticable

  ActiveModelSerializers.config.adapter = :json_api
end
