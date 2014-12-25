require 'rails_helper'

RSpec.describe EmailPattern, :type => :model do
  it { should validate_presence_of :university }
  it { should validate_presence_of :priority }
  it { should validate_presence_of :identity }
  it { should validate_presence_of :regexp }
  it { should belong_to(:university) }

  it "requires regexp to be valid" do
    email_pattern = build(:email_pattern, regexp: '?><')
    expect(email_pattern).to be_invalid
    email_pattern = build(:email_pattern, regexp: '^abc$')
    expect(email_pattern).to be_valid
  end

  describe ".identify" do
    it "identifies an email" do
      create(:university_ntust)

      identity_data = EmailPattern.identify('b10132023@mail.ntust.edu.tw')
      expect(identity_data).to be_a_kind_of(Hash)
      expect(identity_data[:university_code]).to eq('NTUST')
      expect(identity_data[:department_code]).to eq('32')
      expect(identity_data[:identity]).to eq('student')
      expect(identity_data[:identity_detail]).to eq('bachelor')
      expect(identity_data[:sid]).to eq('b10132023')
      expect(identity_data[:started_at].year).to eq(2012)

      # identity_data = EmailPattern.identify('b9732023@mail.ntust.edu.tw')
      identity_data = EmailPattern.identify('AbC.De-#@mail.ntust.edu.tw')
      expect(identity_data).to be_a_kind_of(Hash)
      expect(identity_data[:university_code]).to eq('NTUST')
      expect(identity_data[:identity]).to eq('staff')
      expect(identity_data[:sid]).to eq('abc.de-')
    end
  end
end
