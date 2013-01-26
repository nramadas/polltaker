class TeamsUser < ActiveRecord::Base
  attr_accessible :user_id, :team_id

  belongs_to :user
  belongs_to :team

  validates :user_id, uniqueness: { scope: :team_id }

  def self.make_membership(user, team)
    TeamsUser.create!(user_id: user.id, team_id: team.id)
  end
end