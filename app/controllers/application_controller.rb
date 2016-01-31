class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # toastr display types are "info, success, warning, error"
  # add flash types to match
  TOASTR_TYPES = [:info, :success, :warning, :error]
  add_flash_types(*TOASTR_TYPES)
end
