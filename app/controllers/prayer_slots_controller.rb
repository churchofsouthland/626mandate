class PrayerSlotsController < ApplicationController
  def add
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      due = Time.at(params[:time_i].to_i)

      existing_slot = PrayerSlot.find_by(user: current_user, due: due)
      if existing_slot.present?
        existing_slot.delete
      else
        PrayerSlot.create!(user: current_user, due: due)
      end
      redirect_to root_path
    end
  end
end
