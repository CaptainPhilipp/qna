require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should have_db_column(:body).with_options null: false }
  it { should belong_to :commentable }
  it { should belong_to :user }
end