class PagesController < ApplicationController
  #Start - Monday, March 7 @ 12:00a
  #End - Sat, March 12 @ 11:59p

  def welcome
    @start_date_time = DateTime.parse('2016/02/07').beginning_of_day
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
