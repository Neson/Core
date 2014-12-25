class Unit < ActiveRecord::Base
  include UniversityUnit
  default_scope { order('code ASC') }
end
