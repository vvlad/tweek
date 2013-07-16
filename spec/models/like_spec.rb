require 'spec_helper'

describe Like do
  fixtures(:users, :movies)
  it { should belong_to :user }
  it { should belong_to :movie }


  it "should not allow to create the second like for a given user" do
    Like.create! user: users(:one), movie: movies(:one)
    expect { Like.create! user: users(:one), movie: movies(:one) }.to raise_error(ActiveRecord::RecordInvalid)
  end

end
