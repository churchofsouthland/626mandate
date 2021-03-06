class PagesController < ApplicationController
  def welcome
    start_626 = DateUtils.mandate_start_date # Mon
    end_626 = DateUtils.mandate_finish_date  # Sat

    @calendar_start_date = DateUtils.calendar_start_date

    # HACK: very dumb logic
    # if c is present, have prev link
    # else have next link
    c = params[:c] == '1'
    if c
      @calendar_start_date = DateUtils.calendar_start_date + 1.week
      @next_link = false
      @prev_link = true
    else
      @next_link = true
      @prev_link = false
    end

    if true #TimeZonePresenter.short_name(Time.zone.now) == 'PST'
      @next_link = false
    end

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
    if !user_signed_in?
      redirect_to root_path, flash: { warning: 'You must sign in to do that.' }
    end
  end

  def change_time_zone
    current_user.time_zone = params[:time_zone]
    current_user.save!
    redirect_to time_zone_path, { success: "Time zone set to #{params[:time_zone]}" }
  end
end
