class CreateCalenderEvents < ActiveRecord::Migration
  def self.up
    create_table :calender_events do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :calender_events
  end
end
