class CreateQuestionMemberships < ActiveRecord::Migration
  def self.up
    create_table :question_memberships do |t|
      t.integer :questionnaire_id
      t.integer :question_id

      t.timestamps
    end
  end

  def self.down
    drop_table :question_memberships
  end
end
