class DateUtils
  def self.mandate_start_date
    DateTime.parse(Figaro.env.mandate_start_date).utc
  end

  def self.mandate_finish_date
    DateTime.parse(Figaro.env.mandate_finish_date).utc
  end

  def self.calendar_start_date
    DateTime.parse(Figaro.env.calendar_start_date).utc
  end

  def self.calendar_last_date
    DateTime.parse(Figaro.env.calendar_last_date).utc
  end

  def self.date_time_eq?(dt1, dt2)
    dt1.to_i == dt2.to_i
  end
end
