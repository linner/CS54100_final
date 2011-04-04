class AddStatusToAssignment < ActiveRecord::Migration
  def self.up
    add_column :assignments, :status, :integer
  end

  def self.down
    add_column :assignments, :status
  end
end
