require 'rails_helper'

RSpec.describe College, :type => :model do

  it_behaves_like "a university unit"

  it "has many departments" do
    college_1_in_university_1 = create(:college_with_departments, departments_count: 5, code: "COLG1", university: create(:university, code: "UNIV1"))
    college_1_in_university_2 = create(:college_with_departments, departments_count: 5, code: "COLG1", university: create(:university, code: "UNIV2"))

    colg = college_1_in_university_1
    expect(colg.departments.count).to eq(5)
    colg_dept_univ_codes = colg.departments.all.map { |o| o.university_code }
    expect(colg_dept_univ_codes).to match(Array.new(5) { "UNIV1" })
    expect(colg_dept_univ_codes).not_to include("UNIV2")
  end
end
