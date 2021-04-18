require './lib/http_status'

class ApplicationController < ActionController::API
  include ActionController::Cookies
  include HttpStatus

  #unless Rails.env.development?
  rescue_from Exception,                      with: :response_internal_server_error
  rescue_from ActiveRecord::RecordNotFound,   with: :response_not_found
  rescue_from ActionController::RoutingError, with: :response_not_found
  #end

  # called from route: routing_error
  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  # 200: SUCCESS
  def response_success(body:)
    render status: HttpStatus::SUCCESS,
           :json => {
             body: body
           }
  end

  # 204: NO_CONTENT
  def response_no_content
    render status: HttpStatus::NO_CONTENT
  end

  private

  # 404: NOT_FOUND
  def response_not_found(_, message:nil)
    render status: HttpStatus::NOT_FOUND,
           :json => {
             message: "routing error: #{message} は未定義です",
           }
  end
end
