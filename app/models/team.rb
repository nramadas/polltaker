class Team < ActiveRecord::Base
  attr_accessible :name

  has_many :teams_users
  has_many :users, :through => :teams_users

  validates :name, uniqueness: true

  def self.make_team(name, users)
    team = Team.create!(name: name)
    users.each { |user| TeamsUser.make_membership(user, team) }
    team
  end

  def add_user(user)
    TeamsUser.make_membership(user, self)
  end
end
