class PagesController < ApplicationController
  def welcome
    start_626 = DateUtils.mandate_start_date # Mon
    end_626 = DateUtils.mandate_finish_date  # Sat

    if params.has_key?(:c)
      # TODO: add guard here to make sure c looks valid
      # if it's not could take up cpu cycles
      c_int = params[:c].to_i

      if c_int.between?(DateTime.parse('2016/01/01').to_i, DateTime.parse('2016/12/30').to_i)
        c_start_date = Time.at(c_int)
      end
    end

    @calendar_start_date = c_start_date || DateUtils.calendar_start_date
    @calendar_next_date = @calendar_start_date + 1.week
    @calendar_prev_date = @calendar_start_date - 1.week

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

  def time_zone
  end
end
