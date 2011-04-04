class Assignment < ActiveRecord::Base
  belongs_to :questionnaire
  belongs_to :user

  belongs_to :assigner, :class_name => 'User', :foreign_key => :assigner_id
end