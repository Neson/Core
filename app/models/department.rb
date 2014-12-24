class Department < ActiveRecord::Base
  include UniversityUnit
  default_scope { order('code ASC') }
  belongs_to :college, ->(o) { where "university_code = ?", o.university_code }, primary_key: :code, foreign_key: :college_code
end
