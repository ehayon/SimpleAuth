class CreateSessions < ActiveRecord::Migration
  def self.up
    create_table :sessions do |t|
      t.string :user_id
      t.string :user_agent
      t.string :expiration_time

      t.timestamps
    end
  end

  def self.down
    drop_table :sessions
  end
end
