class Poll < ActiveRecord::Base
  attr_accessible :name, :user_id, :team_id

  has_many :options
  has_many :answers, :through => :options
  has_many :users, :through => :answers
  belongs_to :team

  def self.make_poll(name, options, user, team = nil)
    team_id = (team ? team.id : nil)
    poll = Poll.create!(name: name, user_id: user.id, team_id: team_id)
    options.each { |option| Option.make_option(option, poll) }
    poll
  end

  def self.most_answered
    Poll.joins(:answers)
        .group('polls.id')
        .order('COUNT(answers.id) DESC')
        .first
  end

  def results
    opts = Option.select('options.*, COUNT(answers.user_id) AS ans_count')
                 .where(poll_id: self.id)
                 .joins(:answers)
                 .group('options.id')
                 .order('COUNT(answers.user_id) DESC')

    opts.inject({}) do |results, option|
      results.merge({ option => option.ans_count })
    end
  end

  def most_popular_answer
    results.first
  end

  def answer_count
    answers.count
  end
end
