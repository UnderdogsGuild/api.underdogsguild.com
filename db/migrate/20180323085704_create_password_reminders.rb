class CreatePasswordReminders < ActiveRecord::Migration[5.1]
  def change
    create_table :password_reminders do |t|

      t.timestamps
    end
  end
end
