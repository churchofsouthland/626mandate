class TimeZonePresenter
  def self.short_name(time)
    short_name = time.strftime('%Z')

    if short_name == 'CST'
      'Beijing'
    else
      short_name
    end
  end
end
