require 'rails_helper'

RSpec.describe Department, :type => :model do

  it_behaves_like "a university unit"

  it "belongs to a college" do
    college_1_in_university_1 = create(:college_with_departments, departments_count: 5, code: "COLG1", university: create(:university, code: "UNIV1"))
    college_1_in_university_2 = create(:college_with_departments, departments_count: 5, code: "COLG1", university: create(:university, code: "UNIV2"))

    department_in_university_1 = college_1_in_university_1.departments.last
    expect(department_in_university_1.college).to eq(college_1_in_university_1)

    department_in_university_2 = college_1_in_university_2.departments.last
    expect(department_in_university_2.college).to eq(college_1_in_university_2)
  end
end
