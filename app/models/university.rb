class University < ActiveRecord::Base
  validates_presence_of :code, :name, :short_name
  validates_uniqueness_of :code
end
