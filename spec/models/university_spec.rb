require 'rails_helper'

RSpec.describe University, :type => :model do

  # it { should have_many(:users).through(:members) }
  # it { should have_many(:email_regexps) }
  it { should validate_presence_of :code }
  it { should validate_presence_of :name }
  it { should validate_presence_of :short_name }

  it "validates uniqueness of code" do
    create(:university)
    expect(subject).to validate_uniqueness_of(:code)
  end
end
