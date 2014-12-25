class College < ActiveRecord::Base
  include UniversityUnit
  default_scope { order('code ASC') }
  has_many :departments, ->(o) { where "university_code = ?", o.university_code }, primary_key: :code, foreign_key: :college_code
end
