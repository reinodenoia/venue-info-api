class ApplicationController < ActionController::Base
  include ::Api::Errors
  protect_from_forgery with: :null_session

  def routing_error
    raise RoutingError, 'No route matches'
  end

  private

  def render_data(data)
    render json: { data: data }
  end

  def raise_if_error(data)
    val = data[:error]
    raise val.constantize if val.try(:deconstantize).eql? 'Errors'
  end
end
