class Answer < ActiveRecord::Base
  attr_accessible :option_id, :user_id

  belongs_to :user
  belongs_to :option
  has_one :poll, :through => :option

  validate :poll_creator_cannot_answer, :user_cannot_answer_twice,
           :user_cannot_answer_poll_if_not_in_correct_team

  def self.make_answer(option, user)
    Answer.create!(option_id: option.id,
                   user_id: user.id)
  end

  def poll_creator_cannot_answer
    if user_id == poll.user_id
      errors[:user_id] << "can't answer a poll they created"
    end
  end

  def user_cannot_answer_twice
    if poll.answers.where(user_id: user_id).any?
      errors[:user_id] << "can't answer a poll twice"
    end
  end

  def user_cannot_answer_poll_if_not_in_correct_team
    if poll.team && user.teams.all? { |team| team.id != poll.team_id }
      errors[:user_id] << "isn't in correct team to answer poll"
    end
  end
end
