class PagesController < ApplicationController
  def welcome
    start_626 = DateUtils.mandate_start_date # Mon
    end_626 = DateUtils.mandate_finish_date  # Sat

    @calendar_start_date = DateUtils.calendar_start_date
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
    @inactive_prayer_slots = if start_626.to_i > @calendar_start_date.to_i
                               # build a list
                               {}.tap do |inactive|
                                 i = @calendar_start_date.to_i
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
    end_date_time_i = @calendar_start_date.to_i + 603000
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
