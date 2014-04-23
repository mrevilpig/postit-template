class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	has_many :votes, as: :voteable

	validates :body, presence: true

    def total_votes
    return total_votes = true_votes - false_votes
  end

  def true_votes
    self.votes.where(vote: true).size
  end

  def false_votes
    self.votes.where(vote: false).size
  end
end
