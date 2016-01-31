class PrayerSlotsController < ApplicationController
  def index
    @owned_prayer_slots = PrayerSlot.where(user: current_user).sort
  end

  def add
    if !user_signed_in?
      render json: { message: 'Please sign in to pick time slots.', toastrType: 'warning' }
    else
      due = Time.at(params[:time_i].to_i).utc
      formatted_due = Time.at(due).strftime("%b %d @%l:%M %P")

      existing_slot = PrayerSlot.find_by(user: current_user, due: due)
      if existing_slot.present?
        existing_slot.delete
        message = "Removed<br />#{formatted_due}"
        toastr_type = 'info'
      else
        PrayerSlot.create!(user: current_user, due: due)
        message = "Added<br />#{formatted_due}"
        toastr_type = 'success'
      end

      render json: { message: message, toastrType: toastr_type }
    end
  end
end
