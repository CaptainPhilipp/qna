# frozen_string_literal: true

class Question < ApplicationRecord
  include Attachable
  include Rateable
  include Commentable
  include HasDeltaAssociationUser

  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_one :best_answer, -> { where best: true }, class_name: 'Answer'

  scope :for_last_day, -> { where('created_at > ?', Date.yesterday) }

  after_create :subscribe_author

  validates :title, :body, length: { minimum: 6 }

  private

  def subscribe_author
    Subscription.subscribe_author(self)
  end

  def cache_key
    max_updated_at = maximum(:updated_at).try(:utc).try(:to_s, :number)
    "#{to_s.pluralize}/collection-#{count}-#{max_updated_at}"
  end
end
