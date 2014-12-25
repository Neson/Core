module UniversityUnit
  extend ActiveSupport::Concern

  included do
    belongs_to :university, primary_key: :code, foreign_key: :university_code
    validates :university, presence: true
    validates :code, :name, :short_name, presence: true, uniqueness: { scope: :university_code }
  end

  module ClassMethods

    # ...

  end
end
