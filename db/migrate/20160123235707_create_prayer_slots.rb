class CreatePrayerSlots < ActiveRecord::Migration
  def change
    create_table :prayer_slots do |t|
      t.integer :user_id
      t.datetime :due
      t.timestamps
    end

    add_index :prayer_slots, :user_id
    add_index :prayer_slots, :due
    add_index :prayer_slots, [:user_id, :due], unique: true
  end
end
