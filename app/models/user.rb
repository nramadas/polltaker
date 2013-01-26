class User < ActiveRecord::Base
  attr_accessible :name

  has_many :polls
  has_many :answers
  has_many :teams_users
  has_many :teams, :through => :teams_users

  validates :name, uniqueness: true

  def self.make_user(name)
    User.create!(name: name)
  end

  def answer_poll(option)
    Answer.make_answer(option, self)
  end

  def make_poll(name, options)
    Poll.make_poll(name, options, self)
  end
end
