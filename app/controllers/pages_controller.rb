class PagesController < ApplicationController
  def welcome
    start_626 = DateTime.parse('2016/03/07').beginning_of_day # Mon
    end_626 = DateTime.parse('2016/03/12').end_of_day # Sat

    @start_date_time = DateTime.parse('2016/03/06').beginning_of_day
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
    # inactive when outside 626 prayer schedule or time has passed
    # inactive at beginning
    @inactive_prayer_slots = if start_626.to_i > @start_date_time.to_i
                               # build a list
                               {}.tap do |inactive|
                                 i = @start_date_time.to_i
                                 loop do
                                   inactive[i] = true
                                   i += 30.minutes.to_i
                                   break if i >= start_626.to_i
                                 end
                               end
                             else
                               {}
                             end
    # inactive at end
    end_date_time_i = @start_date_time.to_i + 603000
    inactive_end = if end_date_time_i > end_626.to_i
                     {}.tap do |inactive|
                       i = end_626.to_i + 1
                       loop do
                         inactive[i] = true
                         i += 30.minutes.to_i
                         break if i > end_date_time_i
                       end
                     end
                   else
                     {}
                   end
    @inactive_prayer_slots.merge!(inactive_end)
  end
end
