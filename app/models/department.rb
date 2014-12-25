class Department < ActiveRecord::Base
  include UniversityUnit
  default_scope { order('code ASC') }
  belongs_to :college, ->(o) { where "university_code = ?", o.university_code }, primary_key: :code, foreign_key: :college_code
  delegate :name, :short_name, to: :college, prefix: true, allow_nil: true
end
