class CreateDailyNotifications < ActiveRecord::Migration
  def change
    create_table :daily_notifications do |t|
      t.integer :user_id
      t.integer :prayer_slot_id
      t.timestamps
    end

    add_index :daily_notifications, :prayer_slot_id
  end
end
