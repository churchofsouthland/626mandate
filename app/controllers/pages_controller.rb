class PagesController < ApplicationController
  def welcome
    @prayer_slot_counts = PrayerSlot.group(:due)
                                    .count
                                    .inject({}) do |item, (k,v)|
                                      item[k.to_i] = v;
                                      item
                                    end

    @owned_prayer_slots = PrayerSlot.where(user: current_user)
                                    .inject({}) do |item, record|
                                      item[record.due.to_i] = true;
                                      item
                                    end
  end
end
