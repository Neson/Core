class University < ActiveRecord::Base
  has_many :email_regexps, primary_key: :code, foreign_key: :university_code, :dependent => :destroy
  validates_presence_of :code, :name, :short_name
  validates_uniqueness_of :code
  validates_associated :email_regexps
end
