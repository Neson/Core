class EmailRegexpValidator < ActiveModel::Validator
  def validate(record)
    begin
      /#{record.regexp}/
    rescue RegexpError
      record.errors[:base] << "The Regexp is not vaild!"
    end
  end
end

class EmailRegexp < ActiveRecord::Base
  enum identity: Constant::USER_IDENTITY
  belongs_to :university, primary_key: :code, foreign_key: :university_code
  validates :university, :priority, :identity, :regexp, presence: true
  validates_with EmailRegexpValidator
end
