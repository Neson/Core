require 'rails_helper'

RSpec.shared_examples "a university unit" do
  let(:unit) { build(described_class) }

  it { should belong_to(:university) }
  it { should validate_presence_of :university }
  it { should validate_presence_of :code }
  it { should validate_presence_of :name }
  it { should validate_presence_of :short_name }

  xit { should have_many(:users).through(:members) }
  xit { should have_many(:users).through(:students) }
  xit { should have_many(:users).through(:staffs) }
  xit { should have_many(:users).through(:lecturers) }
  xit { should have_many(:users).through(:professors) }
end
