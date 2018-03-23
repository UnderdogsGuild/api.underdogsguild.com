class CreateRegistrationTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :registration_tokens do |t|

      t.timestamps
    end
  end
end
