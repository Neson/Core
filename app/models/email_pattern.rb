class EmailPatternValidator < ActiveModel::Validator
  def validate(record)
    begin
      /#{record.regexp}/
    rescue RegexpError
      record.errors[:base] << "The Regexp is not vaild!"
    end
  end
end

class EmailPattern < ActiveRecord::Base
  default_scope { order('priority ASC') }

  enum identity: Constant::USER_IDENTITY
  belongs_to :university, primary_key: :code, foreign_key: :university_code

  validates :university, :priority, :identity, :regexp, presence: true
  validates_with EmailPatternValidator

  def self.identify(email)
    all.each do |pattern|

      matchdata = email.match /#{pattern.regexp}/

      if matchdata
        matchdata_hash = matchdata.to_hash
        matchdata_hash[:university_code] = pattern.university_code
        matchdata_hash[:identity] = pattern.identity
        matchdata_hash[:sid] = matchdata.to_s unless matchdata_hash.has_key?(:sid)

        return eval_email_matches(matchdata_hash, pattern)
      end
    end
  end

  private

  def self.eval_email_matches(hash, pattern)
    cxt = V8::Context.new

    { sid:              :sid_eval,
      identity_detail:  :identity_detail_eval,
      department_code:  :department_code_eval,
      unit_code:        :unit_code_eval,
      started_at:       :started_at_eval
    }.each do |key, eval_code|
      if not pattern[eval_code].blank?
        hash[key].gsub!(/[^A-Za-z0-9 \-_\.]/, '')
        cxt['n'] = hash[key]
        hash[key] = cxt.eval(pattern[eval_code])
      end

      if key == :started_at
        hash[key] = Time.at(hash[key].to_i)
      else
        hash[key] = hash[key].to_s
      end
    end

    return hash
  end
end
