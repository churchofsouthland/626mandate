#PrayerSlot.where(due: (DateTime.now)..(DateTime.now + 24.hours))

namespace :mandate do
  desc "send notifications"
  task send_notifications: :environment do
    puts 'start send notifications'
    puts 'finish send notifications'
  end
end
