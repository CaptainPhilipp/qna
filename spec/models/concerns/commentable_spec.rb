require 'rails_helper'

describe 'Commentable concern' do
  with_model :CommentableDouble do
    table { |t| t.timestamps }
    model { include Commentable }
  end

  assign_user

  let(:commentable) { CommentableDouble.create }
  let(:comment) { create :comment, commentable: commentable }

  it 'should have #comments as Comment' do
    expect(comment).to be_a Comment
  end
end