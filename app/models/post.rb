class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :post_categories
	has_many :categories, through: :post_categories
	has_many :votes, as: :voteable

	validates :title, presence: true, length: {minimum: 5}
	validates :url, presence: true

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
