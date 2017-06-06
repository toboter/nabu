
  class Comment < ApplicationRecord

    has_closure_tree

    validates :body, presence: true
    validates :commentator_id, presence: true

    belongs_to :commentable, polymorphic: true
    belongs_to :commentator, class_name: 'User'

    def self.labels
      %w(duplicate mistake typo enhancement)
    end

    # Helper class method to lookup all comments assigned
    # to all commentable types for a given user.
    scope :find_comments_by_user, lambda { |user|
      where(user_id: user.id).order('created_at DESC')
    }

    # Helper class method to look up all comments for
    # commentable class name and commentable id.
    scope :find_comments_for_commentable, lambda { |type, id|
      where(commentable_type: type.to_s, commentable_id: id)
        .order('created_at DESC')
    }

    # Helper class method to look up a commentable object
    # given the commentable class name and id
    def self.find_commentable(commentable_str, commentable_id)
      commentable_str.constantize.find(commentable_id)
    end

  end
