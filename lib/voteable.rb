module Voteable
  extend ActiveSupport::Concern

  def total_votes
    true_votes - false_votes
  end

  def true_votes
    self.votes.where(vote: true).size
  end

  def false_votes
    self.votes.where(vote: false).size
  end

end

#Using normal metaprogramming
=begin
module Voteable
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      my_class_method
    end
  end

  module InstanceMethods
    def total_votes
      true_votes - false_votes
    end

    def true_votes
      self.votes.where(vote: true).size
    end

    def false_votes
      self.votes.where(vote: false).size
    end
  end

  module ClassMethods
    def my_class_method
      has_many :votes, as: :voteable
    end
  end
end
=end
