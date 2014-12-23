class CreateEmailRegexps < ActiveRecord::Migration
  def change
    create_table :email_regexps do |t|
      t.integer :priority, index: true, unique: false, limit: 1, default: 0, null: false
      t.string :university_code, index: true, unique: false, null: false
      t.integer :identity, limit: 1, null: false
      t.string :regexp, null: false

      t.string :sid_eval
      t.string :identity_detail_eval
      t.string :department_code_eval
      t.string :unit_code_eval
      t.string :started_at_eval

      t.timestamps
    end
  end
end
