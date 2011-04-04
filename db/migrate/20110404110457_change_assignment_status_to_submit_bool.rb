class ChangeAssignmentStatusToSubmitBool < ActiveRecord::Migration
  def self.up
    remove_column :assignments, :status
    add_column :assignments, :submitted, :boolean
  end

  def self.down
    add_column :assignments, :status, :integer
    remove_column :assignments, :submitted
  end
end
