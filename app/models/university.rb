class University < ActiveRecord::Base
  has_many :units, primary_key: :code, foreign_key: :university_code, :dependent => :destroy
  has_many :colleges, primary_key: :code, foreign_key: :university_code, :dependent => :destroy
  has_many :departments, primary_key: :code, foreign_key: :university_code, :dependent => :destroy
  has_many :email_patterns, primary_key: :code, foreign_key: :university_code, :dependent => :destroy
  accepts_nested_attributes_for :units, allow_destroy: true
  accepts_nested_attributes_for :colleges, allow_destroy: true
  accepts_nested_attributes_for :departments, allow_destroy: true
  accepts_nested_attributes_for :email_patterns, allow_destroy: true
  validates_presence_of :code, :name, :short_name
  validates_uniqueness_of :code
  validates_associated :email_patterns
end
