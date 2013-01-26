class Option < ActiveRecord::Base
  attr_accessible :body, :poll_id

  belongs_to :poll
  has_many :answers

  validates :body, uniqueness: { scope: :poll_id }

  def self.make_option(option, poll)
    Option.create!(body: option, poll_id: poll.id)
  end

  def count
    answers.count
  end
end
