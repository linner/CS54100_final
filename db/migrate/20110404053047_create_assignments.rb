class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :user_id
      t.integer :questionnaire_id
      t.integer :assigner_id

      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
