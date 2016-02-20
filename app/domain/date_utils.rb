class DateUtils
  # mandate start/end dates are in PT
  def self.mandate_start_date
    ActiveSupport::TimeZone["Pacific Time (US & Canada)"].parse(Figaro.env.mandate_start_date).beginning_of_day
  end

  # mandate start/end dates are in PT
  def self.mandate_finish_date
    ActiveSupport::TimeZone["Pacific Time (US & Canada)"].parse(Figaro.env.mandate_finish_date).end_of_day
  end

  # calendar start/last dates are in user local time
  def self.calendar_start_date
    Time.zone.parse(Figaro.env.calendar_start_date).beginning_of_day
  end

  # calendar start/last dates are in user local time
  def self.calendar_last_date
    Time.zone.parse(Figaro.env.calendar_last_date).end_of_day
  end

  def self.date_time_eq?(dt1, dt2)
    dt1.to_i == dt2.to_i
  end
end
