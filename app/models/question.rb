class Question < ActiveRecord::Base

  has_many :question_memberships
  has_many :questionnaires, :through => :question_memberships

  has_many :responses
  has_many :users, :through => :responses

  validates_presence_of :text
  validates_uniqueness_of :text, :message => ": That question has already been entered in the system."
end