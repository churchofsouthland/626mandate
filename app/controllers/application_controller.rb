class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_filter :set_time_zone

  # toastr display types are "info, success, warning, error"
  # add flash types to match
  TOASTR_TYPES = [:info, :success, :warning, :error]
  add_flash_types(*TOASTR_TYPES)


  # set user's time_zone per request. default to PT.
  def set_time_zone
    old_time_zone = Time.zone
    if current_user && current_user.try(:time_zone).present?
      Time.zone = current_user.time_zone
    else
      Time.zone = Figaro.env.default_time_zone
    end
    yield
  ensure
    Time.zone = old_time_zone
  end
end
