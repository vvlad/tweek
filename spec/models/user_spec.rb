require 'spec_helper'

describe User do

  it { should validate_presence_of :name}
  it { should validate_uniqueness_of :email}
  it { should allow_value('test@example.com').for(:email)}
  it { should_not allow_value('invalid email address',nil).for(:email) }


  describe "#normalize_email" do
    it "should downcase the email address" do
      subject.email = "UPPER@CA.SE"
      subject.valid?
      subject.email.should eq "upper@ca.se"
    end

    it "should trim the email address" do
      subject.email = "  UPPER@CA.SE  "
      subject.valid?
      subject.email.should eq "upper@ca.se"
    end


  end
end
