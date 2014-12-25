require 'rails_helper'

RSpec.describe University, :type => :model do

  xit { should have_many(:users).through(:members) }
  it { should have_many(:colleges) }
  it { should have_many(:departments) }
  it { should have_many(:units) }
  it { should have_many(:email_patterns) }
  it { should validate_presence_of :code }
  it { should validate_presence_of :name }
  it { should validate_presence_of :short_name }

  it "validates uniqueness of code" do
    create(:university)
    expect(subject).to validate_uniqueness_of(:code)
  end
end
