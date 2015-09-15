class AddPrefferedWorkingHourToUsers < ActiveRecord::Migration
  def change
    add_column :users, :preferred_working_hour, :integer, default: 8
  end
end
