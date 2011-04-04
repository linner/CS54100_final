class Questionnaire < ActiveRecord::Base
  has_many :assignments
  has_many :users, :through => :assignments

  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :question_memberships
  has_many :questions, :through => :question_memberships

  belongs_to :user, :foreign_key => 'author'
end