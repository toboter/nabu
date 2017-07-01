require "nabu/engine"
require "closure_tree"

module Nabu
  extend ActiveSupport::Concern

  included do
    has_many :comment_threads, class_name: 'Comment', as: :commentable
    class_attribute :is_commentable
  end

  # Helper class method to lookup comments for
  # the mixin commentable type written by a given user.
  def find_comments_by_user(user)
    Comment.where(commentator_id: user.id, commentable_type: self.class.name)
      .order('created_at DESC')
  end
  # Helper method to display only root threads, no children/replies
  def root_comments
    comment_threads.where(parent_id: nil)
  end
  # Helper method to sort comments by date
  def comments_ordered_by_submitted
    Comment.where(commentable_id: id, commentable_type: self.class.name)
      .order('created_at DESC')
  end
  # Helper method that defaults the submitted time.
  def add_comment(comment)
    comments << comment
  end

  # methods defined here are going to extend the class, not the instance of it
  module ClassMethods
    def self.is_commentable
      true
    end
  end
end
