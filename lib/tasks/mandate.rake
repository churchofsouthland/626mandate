#PrayerSlot.where(due: (DateTime.now)..(DateTime.now + 24.hours))

namespace :mandate do
  desc "send notifications"
  task send_notifications: :environment do
    puts 'start send notifications'

    PrayerSlot.where(due: (DateTime.now)..(DateTime.now + 24.hours)).find_each do |slot|
      puts slot.inspect
    end

    puts 'finish send notifications'
  end
end
