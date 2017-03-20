namespace :mandate do
  desc "send notifications"
  task send_notifications: :environment do
    puts 'start send notifications'
    UserNotifier.send_daily_notification(User.find_by(email: 'daniel.kiros@gmail.com', 'due soon').deliver

    #all_slots = PrayerSlot.where(due: (DateTime.now)..(DateTime.now + 24.hours)).map(&:id)
    #sent_slots = DailyNotification.all.map(&:prayer_slot_id)
    #need_send_slots = all_slots - sent_slots

    #PrayerSlot.where(id: need_send_slots).find_each do |slot|
      ## log that notification was sent
      #DailyNotification.create(user_id: slot.user.id, prayer_slot_id: slot.id)
      ## send the notification
      #time_zone = slot.user.time_zone || Figaro.env.default_time_zone
      #due_text = slot.due.in_time_zone(time_zone).strftime('%A, %B %e, %l:%M %P %Z')
      #puts "Your prayer time is coming up: #{due_text}"
      #UserNotifier.send_daily_notification(slot.user, due_text).deliver
    #end

    puts 'finish send notifications'
  end
end
